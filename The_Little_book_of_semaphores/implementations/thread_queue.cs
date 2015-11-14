// Implement a thred queue. When multiple threds wait that thing gets unblocked there is no order
// guaranteed about their run. So make a queue to unblock them in the same order as they were blocked.
//

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

class TQueue
{
    private Mutex access = new Mutex();
    private Queue<Mutex> queue = new Queue<Mutex>();

    public void Wait()
    {
        access.WaitOne();
        var mutex = new Mutex();
        queue.Enqueue(mutex);
        access.ReleaseMutex();
        
        mutex.WaitOne();
    }

    public void Signal()
    {
        Mutex result = null;
        access.WaitOne();
        if (queue.Count > 0)
        {
            result = queue.Dequeue();
        }
        access.ReleaseMutex();
        
        if (result != null) {
        result.ReleaseMutex();
        }
    }

    static void Main()
    {
        var q = new TQueue();
        var threads = Enumerable.
                        Range(1, 5).
                        Select(x => new Thread(() => {
                                    Console.Write("x => {0} ", x);
                                    q.Wait();
                                    Console.Write("x => {0} ", x);
                                })).ToList();
        
        threads.ForEach(x => x.Start());
        Console.WriteLine();
        threads.ForEach(x => q.Signal());
    }
}
