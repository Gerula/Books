# 3. Basic synchronization patterns

Focusing on solving both serialization and mutual exclusion using semaphores.

## 3.1 Signaling

The simplest scenario of a semaphore is signaling - a thread signals another thread. This makes possible the guarantee
that a thread runs before another thus solving serialization.

Simple:

```
sem = semaphore(0)
```

Thread A:
```
print 'a'
sem.signal() // sem.Release()
```

Thread B:
```
sem.wait() // sem.WaitOne()
print 'b'
```

## 3.2 Rendezvous

Puzzle (how exciting!) : Generalize the signal pattern so that it works both ways. A has to wait for B
and vice versa. So given the code:

```
A:                  B:
1. statement_a1     1. statement_b1
2. statement_a2     2. statement_b2
```

we want to guarantee that a1 happens before b2 and that b1 happens before a2.
Hint was given: two semaphores.

### 3.2.2 Solution:

```
first = semaphore(0)
second = semaphore(0)

A:                  B:
1. statement_a1     1. statement_b1
2. first.signal()   2. second.signal()
3. second.wait()    3. first.wait()
4. statement_a2     4. statement_b2
```
Above is my solution.

### 3.2.3 Deadlock 1

Example of an obvious deadlock.

```
first = semaphore(0)
second = semaphore(0)

A:                  B:
1. statement_a1     1. statement_b1
2. second.wait()    2. first.wait()
3. first.signal()   3. second.signal()
4. statement_a2     4. statement_b2
```
What's a deadlock you ask? Well it's a state in a multiprocessing system in which advancement is not possible because of a
circular dependency in resources (I just squeezed out this definition).

The actual definition from wikipedia (more suited for the plebs): a situation in which two or more competing actions
are waiting for each other to finish and thus neither ever does.

## 3.3 Mutex

A mutex is for mutual exclusion. It's weird that everyone is like no way, a sempahore != mutex but here we are in this book
where we need to implement a mutex with a semaphore.

Puzzle: add a mutex to enforce mutual exclusion:

```
A:                      B:
1. count = count + 1    1. count = count + 1
```

### 3.3.1 Hint

It basically tells you what to do, pffff.

### 3.3.2 Solution (by me)

```
mufex = semaphore(1)

A:                      B:
1. mufex.wait()         1. mufex.wait()
2. count = count + 1    2. count = count + 1
3. mufex.signal()       3. mufex.signal()
```
Notes on the solution from the book (crushed it, btw):
- this is a *symmetric* solution as both threads are running the exact same thing. 
- *symmetric* solutions are easier to generalize as in this case for instance we can have as many threads as we want and it won't break the protocol
- what's happening between calls to the semaphore is called a *critical section* (at most one thread executes it at any given moment)

## 3.4 Multiplex

Puzzle (yay!): Generalize the previous solution but allow a maximum of n threads inside the critical section (it's no longer a critical section
but whatever, man).

I'll leave this for tomorrow night but thankfully C# has max value in the semaphore. This pseudo code doesn't.
So it's either invert by having the semaphore start with n or do a critical section on the count.


