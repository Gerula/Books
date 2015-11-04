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


