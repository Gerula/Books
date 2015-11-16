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
