# 2. Semaphores

## 2.1 Definition

A semaphore is like an integer variable with the following properties:
- after initializing it, the only operations allowed are increment and decrement
- reading the value is not allowed
- when a thread decrements the semaphore if the result is negative it blocks and cannot continue until another thread increments it
- when a thread increments it one of the waiting threads gets unblocked. In C# the spec makes no guarantees about the order. It's 
neither FIFO nor LIFO

Blocking means that the thread notifies the scheduler that it cannot continue so the scheduler will reschedule it.

Notes:
- there is no way to know if a thread will be blocked or not. You can prove that if the code is clear but in general
you cannot 'query' the semaphore
- if a thread increments the semaphore and wakes another thread they will run in parallel
- when a semaphore is signaled there is no way of knowing how many threads are waiting

So given value X of a semaphore:

*if X > 0 then* there can be X threads that if they decrement the semaphore without blocking
*if X == 0 then* there are no threads waiting but if a thread tries to decrement it will block
*if X < 0 then* there are X threads waiting

## 2.2 Syntax

I will use pseudo-code for the notes and C# for the implementations.
So a semaphore would look like this:

```
sem = semaphore(3)
```
3 is the initial value.
I finally got why C# does this.

```
var sem = new SemaphoreSlim(0, 3)
```

This means that there can be max 3 threads concurrently running, with initial value 0.
So the creator thread 'owns' it and all of the threads dependent on the semaphore will block until
the creator releases them all. Cool.

Also C# allows you to query:

```
public int CurrentCount { get; }
```
top kek

Mapping:
- signal - increment - release()
- wait - decrement - waitone()

Or V and P if you speak freaky dicky dutch.

## 2.3 Why?

- Deliberate constraints to avoid errors. Well that's generic..
- Solutions with semaphores are clean and organized. Compared to what?
- Can be implemented efficiently. Need to research how it's implemented in .NET.

So in C# it is generally recommended to use SemaphoreSlim class as it's more lightweight (due to the fact that it cannot
span processes - cannot be a named semaphore). Need to dig deeper into this, probably look at the source code.

Semaphores are implemented by using APIs exposed through Kernel32 manipulating Kernel Dispatch Objects.
