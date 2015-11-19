# 4. Classical synchronization problems

All of these problems can be found in OS textbooks.
In the real world these problems do not happen (I call bullshit) and if they happen the solutions are not much like these (then how are they?).

## 4.1 Producer - consumer problem

In multithreading there is often a division of labor between threads. One thread produces a value and puts it into a data structure
and another thread consumes the value from the data structure.

For example events: an event happens and a thread produces an event object and puts in in the buffer. Other threads take the events
out of the buffer and processes them, just like some sort of event handlers.

Constraints needed to make this system work:
- while an item is added or removed from the buffer it is in an inconsistent state. So the threads need exclusive access to the buffer.
- if a consumer finds the buffer empty, it will block until an item becomes available.

Assume that producers perform:
```
event = waitForEvent()
buffer.add(event)
```

and consumers:
```
event = buffer.get()
event.process
```

Access to the buffer needs to be exclusive (critical section) but event processing and waiting can run concurrently.
Make this happen.

My solution:
```
mutex = semaphore(1)
elements = semaphore(0)

P:
while true
    event = waitForEvent
    mutex.wait()
    buffer.add(event)
    mutex.signal()
    elements.signal()

C:
while true
    elements.wait() 
    mutex.wait()
    event = buffer.get()
    mutex.signal()
    event.process

```

FUCKING NAILED IT! Apparently years of schooling is worth something.

Puzzle: why is this broken?

```
mutex.wait()
    items.wait()
    event = buffer.get()
mutex.signal()
event.process()
```

because deadlock. If the consumer runs first then nothing happens as the buffer is empty so it will block on the items but at the same
time it won't release the mutex so the producer can't add stuff to it.

### 4.1.4 Producer - consumer with finite buffer

The previous problem assumes the buffer is infinite but in the real world the consumer would block when the buffer is full.
So we could check the value of the semaphore and block if it's full. But we can't (we can in C#).

Implement the finite buffer constraint.
```
mutex = semaphore(1)
elements = semaphore(0)
consumed = semaphore(n)

P:
while true
    event = waitForEvent
    consumed.wait()
    mutex.wait()
        buffer.add(event)
    mutex.signal()
    elements.signal()

C:
while true
    elements.wait() 
    mutex.wait()
        event = buffer.get()
    mutex.signal()
    consumed.signal()
    event.process

```

Nailed it again!
I will leave a C# solution [here](implementations/producers_consumers.cs)

## 4.2 Readers - writers problem

Any datastructure read and modified by concurrent threads. The problem is that when the data is modified, nobody can be inside the
critical section as readers may read inconsistent data.
Constraints are:
- Any number of readers can be in the critical section simultaneously
- Writers have exclusive access to the critical section.

This exclusion pattern is called **categorical mutual exclusion** as a thread in a critical section does not necessarily exclude
other threads unless the thread belongs to a certain category.

Implement that.

```
readers = 0
mutex = semaphore(1)
roomEmpty = semaphore(1)
value = NaA

R:
mutex.Wait()
    readers ++
    if readers == 1
        roomEmpty.Wait()
mutex.Signal()

read value

mutex.Wait()
    readers --
    if readers == 0
        roomEmpty.Signal()
mutex.Signal()

W:
roomEmpty.Wait()
value = random
roomEmpty.Signal()
```

So what's happening here:
- the writer will only write if the *room is empty*. This means that there is no other thread reading or writing the value.
- the reader will first increment the number of readers. If it's the first reader it need to wait for the room to be empty. This means
that there are no other readers for sure (it's the first reader) so there is a writer and it needs to wait on it to finish.
- after waiting the reader enters the critical section. Here there can be multiple writers.
- in the end, the reader will decrement the number of readers anf if it's the last reader then it will signal that the room is empty
thus letting know any of the waiting writers that it's free to write now.
- this pattern in which for a series of threads the first one locks a resource and the last one unlocks a resource is often called
a **lightswitch**. The book implements it so I also implement it and rewrite the solution [here](implementations/reders_writers_1.cs).

### 4.2.3 Starvation

The code does not deadlock but it may starve writers. So this can be called *readers writers problem with reader preference* or something.
So in theory if there are a lot of readers the writers can wait forever for the reders to finish and they never will.

Modify the solution above so that when a writer arrives, existing readers can finish but all new readers need to wait for the writer
to finish.

```
value = -1
readers = 0
emptyRoom = semaphore(1)
mutex = semaphore(1)
writers = 0
writer_mutex = semaphore(1)
writerLock = semaphore(1)

W:
writer_mutex.Wait()
    writers++
    if writers == 1
        writerLock.Wait()
writer_mutex.Signal()

emptyRoom.Wait()
    value = random
emptyRoom.Signal()

writer_mutex.Wait()
    writers--
    if writers == 0
        writerLock.Signal()
writer_mutex.Signal()

R:

writerLock.Wait()
mutex.Wait()
    readers++
    if readers == 1
        emptyRoom.Wait()
mutex.Signal()

read value

mutex.Wait()
    readers--
    if readers == 0
        emptyRoom.Signal()
mutex.Signal()

```

I'm going over this as it's using the turnstile pattern which I don't think it's fair.

This needs to be revisited as it's very fucky. Maybe read it from Tanenbaum's book or something...

## 4.3 No starve mutex

We discussed **categorical starvation** which means that a certain category of threads may never run (thus starve).
We will talk about **thread starvation** in general now.

Partially starvation is also related to the scheduler as if the scheduler does not schedule a thread it will starve regardless of synchronization mechanisms.

**Property one** - if there is only a thread that is ready to run then the scheduler has to let it run.

**Property two** - if a thread is ready to run then the time it waits to run is finite / bounded.

**Property three** - if a thread signales a semaphore on which other threads are waiting, one of the waiting threads needs to be woken.

Consider the following starvation case:

```
while true
    mutex.wait
    do_stuff
    mutex.signal
```

A, B and C are running this. A goes first, does stuff while B and C wait. Then A signals and B gets woken. The same way
B does stuff while A and C wait. B unlocks and A gets woken. C starves. Poor C.

**Property four** - if a thread is waiting on a semaphore, the number of threads that will be woken before it is bounded.

For example, in the code above if the mutex keeps a FIFO structure then when C will get scheduled before A as it came first.

A semaphore with property three is called a **weak semaphore** (DYEL semaphore) and a semaphore with property four is a **strong semaphore**.
Dijkstra conjectured that it's impossible to solve the starvation problem with weak semaphores but in 1979 Morris proved it wrong
assuming that the total number of threads is finite.

Fun fun fun, let's prove Dijkstra wrong (Dijkstra was awesome btw, I can't believe this bullshit).
Write a solution to the mutual exclusion problem with weak semaphores. 
The code should have the following guarantee: once a thread arrives and attempts to enter the mutex there is a bound on the 
number of threads that can proceed ahead of it. The total number of threads is finite.

### 4.3.1 Hint

This is heavy shit so I'll just read it.

It uses two waiting rooms before the critical section and there are two phases:
- first phase the first turnstile is open and the second is closed so all threads accumulate in room 1.
- second phase first turnstile is closed and no other threads can enter and the second is open so threads can enter the critical section.

So although there may be an arbitrary number of threads in the waiting room, each one is guaranteed to enter the critical section
before any future arrivals.

```
room_one_count = 0
room_two_count = 0
mutex = semaphore(1)
room_one = semaphore(1)
room_two = semaphore(0)

Thread:

mutex.wait()
    room_one_count ++
mutex.signal()

room_one.wait()
    room_two_count ++
    mutex.wait()
        room_one_count --
        if room_one_count == 0
            mutex.signal()
        else
            mutex.signal()
            room_one.signal()

room_two_wait()
    room_two_count --

    ### critical section over here

    if room_two_count == 0
        room_one.signal()
    else
        room_two.signal()
```

Wow! This is genius. I need to do this by hand to better understand it. Also, make this into an implementation is C# [here](implementations/strong_semaphore.cs)

## 4.4 Dining philosophers 

I'll leave this one for when I'm clear headed.
