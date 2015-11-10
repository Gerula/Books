# 1. Introduction

## 1.1 Synchronization

Synchronization 
- in the general definition events happening at the same time.
- in computing, event ordering.

Our interest lies in terms of **synchronization constraints**: 
- **Serialization** - events happening in a particular order
- **Mutual exclusion** - events must not happen at the same time

## 1.2 Execution model

In "nature" synchronization can happen with a clock. In computing there is no universal clock and existing clocks
are lacking in precision or in clock synchronization between parallel processes.

In terms of synchronization, there is no difference between parallel processors and between multiple threads running
in parallel.

In a single processor, multiple threads run sequentially and they are scheduled in a manner outside of the control of the
programmer thus giving the illusion of parallelism.

## 1.3 Serialization with messages

Alice and Bob need to eat lunch but not at the same time.

Alice: a) eat breakfast b) work c) eat lunch d) call Bob
Bob: a) eat breakfast b) wait for Alice to call c) wat lunch

Phone call - is the message passed.
Alice and Bob are eating lunch *sequentially* (Alice then Bob) but they are eating breakfast
*concurrently*. They may or may not be eating breakfast at the same time, but as far as we're concerned
as observers, the events happened within the same timeframe with no order defined.

## 1.4 Non-determinism

Concurrent programs are non-deterministic - it's impossible to tell by looking at the program what will be the exact
ordering of the parallel instructions due to the non-deterministic (it's actually deterministic from the theoretical standpoint but 
it seems non-deterministic due to how it works and all the parameters involved) nature of the scheduler or the compiler optimizations.

## 1.5 Shared variables

Processes don't have access to other processes memory but threads which belong to the same process share 
the processes memory. This means that variables can be shared between threads.

If threads are not synchronized if they are reading a value from the variable it's impossible to tell by looking at the
program if there is a guarantee that the latest value will be read or not thus many programs enforce the constraint that
the reader should wait for the writer to finish before reading the value.

Other scenarios are concurrent writes (multiple writers) and concurrent updates (multiple reader-writers).

### 1.5.1 Concurrent writes

A

```
a1 x = 5
a2 print x
```
B

```
b1 x = 7
```

What path prints and yields 5? b1 -> a1 -> a2
What path prints and yields 7? a1 -> b1 -> a2
Is there a path that prints 7 and yields 5?  No.
Prove it: Assuming there is such a path this would mean that a2 happens before a1.
At least the C# spec guarantees that instructions would not be reordered to the extent of observable effects
whithin the current thread.

### 1.5.2 Concurrent updates

Basically update (read then write based on the read) if not atomic it spells trouble because two unsynchronized threads doing 

```
temp = x
x = temp + 1
```

will have unexpected results.

Fortunately there is Interlocked.Increment.

### 1.5.3 Mutual exclusion with message passing

Just like serialization, mutual exclusion can also be implemented with message passing.

You and Bob operate a nuclear plant and monitor the warnings. Both allowed to eat lunch but never at the same time.

Figure out a system of message passing (phone calls) that enforces these restraints.
What's the min number of messages?

```
send "want to eat"
\\ will sleep on this one..
```


