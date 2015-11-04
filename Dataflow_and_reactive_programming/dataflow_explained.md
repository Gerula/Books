Dataflow eliminates the need for polling to check if the data has arrived, in turn it reacts to 
changing data, updating whenever data arrives - interesting speach: I wonder how this is actually implemented. Someone at some point 
*needs* to check to see if data has arrived and turn a switch on or trigger something. This is why I'm reading this book. How the hell
does this work if there's nothing polling the data at some lower level.

## Nodes

A node is a unit of computation. The model couldn't care less what it does aside from the fact
that it takes some data in and spits some data out because the model cares only about moving data around.
     ____
--->|____|->   <- this is an ASCII art node lol. It's got input and output port.

This quote from the book.. I have a problem with it:

> Nodes are often functional, but it is not required.
> By “functional” I mean that if you give it the same inputs at two separate times,
> it will always return the same answer.

This is called fucking idempotence. What the fuck does "functional" mean? The node is a goddamn function, here F : {inputs} -> {outputs}.

Another quote I have a problem with:

> Executing a node… asking it to perform its calculation

The model doesn't say anything about asking the node nothing. The node receives data, it triggers, right?

## Data

Data can be anything. Dataflow prefers immutable data (I wonder why).
Data can be called tokens.

## Arc

Edge, link, connection, wire, path, etc.. something something connecting nodes over which 'the data' travels.

Arcs have capacity - only so much data can travel on it. - Of course if you're webscale there is much data unlimited.

## Graphs

Directed graphs with nodes and arcs - surprise. This is the actual program from this model's perspective.

By default the graph is idle. Doesn't do nothing but then there is data on the first arc (topo sort maybe?) and then the first node
fires and then the node connected to the first one - probably through some sort of BFS.

> Node A and B can both execute at the same time. Since the two nodes don’t share any data and are “functional” 

There he goes again with the functional bullshit.

-> A -> B -> C ->

If you put stuff in A, A processes and passes it to B. In the meantime A triggers again while B processes. Producer - consumer
circlejerk if C gives it back to A, right?

There are some preconditions for node activation - it wwould have been great to put them in the node section, right?
The preconditions are that there is data on the input and there is space on the output.

## Features

### Push or pull data

Basic push or pull but the pull is if-y. It is supposedly used when a node's processing is costly and needs to produce something
in a lazy fashion. My question is how do you tell the node to pull? Just by telling the node to pull, it violates the data movement
principle. 

### Mutable or immutable data

Immutable data is prefered, of course. Because if you send x to A and B and both processes it, you need to do something like
mutual exclusion and thus parallelism is affected.

Token copying is indeed expensive but bugs are more expensive.

### Static or dynamic

Dynamic dataflows can change at runtime. For example when using a higher-order function. Or you can change the arcs at runtime. Big 
mess. Static dataflows don't change. Hardware is a static dataflow.







