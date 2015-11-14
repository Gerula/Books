// Implement a thred queue. When multiple threds wait that thing gets unblocked there is no order
// guaranteed about their run. So make a queue to unblock them in the same order as they were blocked.
//

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

class TQueue
{
    private Object padlock = new Object();
    private Queue<Tuple<SemaphoreSlim, int>> queue = new Queue<Tuple<SemaphoreSlim, int>>();

    public void Wait(int i)
    {
        var sem = new SemaphoreSlim(0);

        lock (padlock) 
        {
            Console.WriteLine("Added {0}", i);
            queue.Enqueue(Tuple.Create(sem, i));
        } 

        sem.Wait();
    }

    public void Signal()
    {
        Tuple<SemaphoreSlim, int> result = null;
        lock (padlock)
        {
            if (queue.Count > 0)
            {
                result = queue.Dequeue();
                Console.WriteLine("Removed {0}", result.Item2);
            }
        }

        result.Item1.Release();
    }

    static void Main()
    {
        var q = new TQueue();
        var threads = Enumerable.
                        Range(1, 5).
                        Select(x => new Thread(() => {
                                    q.Wait(x);
                                })).ToList();
        
        threads.ForEach(x => x.Start());
        Console.WriteLine();
        threads.ForEach(x => { 
                    q.Signal();  
                });
    }
}
