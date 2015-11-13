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

~~I'll leave this for tomorrow night but thankfully C# has max value in the semaphore. This pseudo code doesn't.
So it's either invert by having the semaphore start with n or do a critical section on the count.~~

I was right:

```
bouncer = semaphore(n)

A:                      
1. mufex.wait()        
2. party()
3. mufex.signal()     
```
but the order in line is not guaranteed.

## 3.5 Barrier

Generalize the rendezvous solution to allow for:

```
rendezvous
criticalpoint
```
So there are n threads. All of them should wait for each other at rendezvous and then all of them proceed.
This is tricky. In C# it's easy, just set to 0, create N threads all of them waiting for the semaphore and then
release n on the semaphore in the main thread.

My solution below:

```
barrier = semaphore(0)
count = 0
mutex = semaphore(1)

1. mutex.wait()
2. count = count + 1
3. if count == n - 1
4. barrier.signal()
5. mutex.signal()
6. barrier.wait()
```
Which was bad as it doesn't reactivate the barrier.

### 3.5.1 Non-solution:

```
barrier = semaphore(0)
count = 0
mutex = semaphore(1)

1. mutex.wait()
2. count = count + 1
3. mutex.signal()
4. if count == n - 1
5.      barrier.signal()
6. barrier.wait()
```
Puzzle: why is this wrong? ~~Because it reads count outside of the critical section.~~ Wrong! Deadlock.

Right solution:
```
barrier = semaphore(0)
count = 0
mutex = semaphore(1)

1. mutex.wait()
2. count = count + 1
3. mutex.signal()
4. if count == n - 1
5.      barrier.signal()
6. barrier.wait()
7. barrier.signal()
```
Notes:
- this is called a **turnstile** as it allows one thread to go at a time and each thread activates the next.
- Indeed, it does seem dangerous to read count outside of the mutex (I knew it! I fucking knew it) but in this case it's fine as we don't care which thread starts the turnstile.
- also, if you put the turstile inside the mutex you're fucked in a deadlock as the mutex remains locked for the other threads and the locking thead waits on the turnstile.

## 3.6 Reusable barrier

The previous solution leaves the turnstile open. Make it reusable by closing it.

My solution:

```
barrier = semaphore(0)
count = 0
mutex = semaphore(1)

1. mutex.wait()
2. count = count + 1
3. mutex.signal()
4. if count == n - 1
5.      barrier.signal()
6. barrier.wait()
7. if count != n - 1
8.      barrier.signal()
```

Geez I must be fucking stupid.

Solution:
```
barrier_1 = semaphore(0)
barrier_2 = semaphore(1)
mutex = semaphore(1)

1.      mutex.wait()
2.      count = count + 1
3.          if count == n - 1
4.              barrier_2.wait()
5.              barrier_1.signal()
6.      mutex.signal()
7.      barrier_1.wait()
8.      barrier_1.signal()
9.      mutex.wait()
10.         count = count - 1
11.         if count == 0
12.             barrier_1.wait()
13.             barrier_2.signal()
14.     mutex.signal()
15.     barrier_2.wait()
16.     barrier_2.signal()
```

Wow :(.

This is called a two-phase barrier. Then a whole paragraph describing how all non-trivial sync is fucky like this one, than formal proof is lunacy and that we need to rely on these types of patterns.

A simpler solution appears out of nowhere if we preload the second barrier with the right number of threads. Also the previous solution does more context switching than necessary.
I'll write this one myself.

```
barrier_1 = semaphore(0)
barrier_2 = semaphore(n - 1)
mutex = semaphore(1)

1.      mutex.wait()
2.      count = count + 1
3.          if count == n - 1
4.              barrier_1.signal()
5.      mutex.signal()
6.      barrier_1.wait()
7.      barrier_1.signal()
8.      mutex.wait()
9.         count = count - 1
10.         if count == 0
11.             barrier_2.wait()
12.     mutex.signal()
13.     barrier_2.wait()
```

Ok, didn't write it myself, I looked at the book.

## 3.7 Queue

Semaphores can be used to represent a queue. The initial value is 0 and it is not possible to release unless there is a thread
waiting so the value of the semaphore is never positive.

There is a dance and there are two queues - leaders and followers. When a leader arrives it checks to see if there is a follower
if there is they can both proceed, otherwise it waits. Similarily for a follower. Implement this filth.

```
leaders = semaphore(0)
followers = semaphore(0)

Leader                      Follower
1. followers.signal()       1. leaders.wait()
2. leaders.wait()           2. followers.signal()
3. dance()                  3. dance()
```

I smell something bad about this...
Not doing the extension.

## 3.8 FIFO queue

When a semaphore is signaled there is no way to tell which thread gets to run first. The runtime makes no guarantee (at least in C#)
but we can implement this ourselves.

Implement it. I actually had to implement this in an interview. I'll do it in C#, [here](implementations/fifoqueue.cs)

