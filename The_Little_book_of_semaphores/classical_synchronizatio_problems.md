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
