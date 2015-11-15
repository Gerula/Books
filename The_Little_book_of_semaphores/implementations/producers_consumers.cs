// Producers consumers with finite buffer
//

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

class Program
{
    static void Main()
    {
        var buff = new Queue<int>();
        var itemSemaphore = new SemaphoreSlim(0);
        var fillSemaphore = new SemaphoreSlim(4, 4);
        var padLock = new Object();
        var random = new Random();
        var producers = Enumerable
                        .Range(1, 10)
                        .Select(x => new Thread(() => {
                                        var loops = random.Next(1, 30);
                                        for (int i = 0; i < loops; i++)
                                        {
                                            var item = random.Next(1, 100);
                                            fillSemaphore.Wait();
                                            lock (padLock)
                                            {
                                                buff.Enqueue(item);
                                                Console.WriteLine("Produce {0}, Queue [{1}]", item, String.Join(", ", buff));
                                                itemSemaphore.Release();
                                            }
                                        }
                                    }));

        var consumers = Enumerable
                        .Range(1, 5)
                        .Select(x => new Thread(() => {
                                        while (true)
                                        {
                                            Console.WriteLine("Consumer {0} waiting", x);
                                            itemSemaphore.Wait();
                                            lock (padLock)
                                            {
                                                var item = buff.Dequeue();
                                                Console.WriteLine("Consumer {0} consuming {0} Queue [{1}]", x, item, String.Join(", ", buff));
                                            }

                                            fillSemaphore.Release();
                                        }
                                    }));

        producers
        .Concat(consumers)
        .OrderBy(x => random.Next())
        .ToList()
        .ForEach(y => y.Start());
    }
}
