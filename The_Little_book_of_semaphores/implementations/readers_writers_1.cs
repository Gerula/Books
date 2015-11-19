// Readers - writers problem
//
// Any datastructure read and modified by concurrent threads. The problem is that when the data is modified, nobody can be inside the critical section as readers may read inconsistent data. Constraints are:
//
// Any number of readers can be in the critical section simultaneously
// Writers have exclusive access to the critical section.
//
// This exclusion pattern is called categorical mutual exclusion as a thread in a critical section does not necessarily exclude other threads unless the thread belongs to a certain category.
//
// Implement that.
//

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

class Program
{
    static Random random = new Random();

    class Node 
    {
        public Node Next { get; set; }
        public int Val { get; set; }
        public override String ToString()
        {
            return String.Format("{0} {1}", Val, Next == null ? String.Empty : Next.ToString());
        }

        public static Node Random()
        {
            Node result = null;
            Enumerable
            .Range(1, random.Next(2, 10))
            .Select(y => random.Next(1, 10))
            .Reverse()
            .ToList()
            .ForEach(x => {
                result = new Node { Val = x, Next = result };
            });

            return result;
        }
    }

    static void Main()
    {
        Node node = null;
        var roomEmpty = new SemaphoreSlim(0);
        int num_readers = 0;
        var readersMutex = new SemaphoreSlim(1);

        var readers = Enumerable
                      .Range(1, 10)
                      .Select(x => new Thread(() => {
                                    while (true)
                                    {
                                        readersMutex.Wait();
                                        num_readers++;
                                        if (num_readers == 0)
                                        {
                                            roomEmpty.Wait();
                                        }

                                        readersMutex.Release();
                                        
                                        if (node != null)
                                        {
                                            Console.WriteLine("I am {0} and I just read {1}", x, node);
                                        }

                                        readersMutex.Wait();
                                        num_readers--;
                                        if (num_readers == 0)
                                        {
                                            roomEmpty.Release();
                                        }

                                        readersMutex.Release();
                                    }
                                  }));
        var writers = Enumerable
                      .Range(1, 3)
                      .Select(x => new Thread(() => {
                                    while (true)
                                    {
                                        roomEmpty.Wait();
                                        node = Node.Random();
                                        roomEmpty.Release();
                                        Console.WriteLine("I am {0} and I just wrote {1}", x, node);
                                    }
                                  }));
        
        readers
        .Concat(writers)
        .OrderBy(x => random.Next())
        .ToList()
        .ForEach(y => y.Start());
    }
}
