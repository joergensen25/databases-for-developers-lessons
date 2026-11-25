using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ORMtest
{
    internal class Program
    {
        static void Main(string[] args)
        {
            ORMtestEntities DB = new ORMtestEntities();
            var huse = (from f in DB.ferieboligs
                        where f.maxpersoner >= 4
                        select f);
            foreach (var f in huse )
                {
                    Console.WriteLine(f.boligid + " " + f.maxpersoner);
                }

        }
    }
}
