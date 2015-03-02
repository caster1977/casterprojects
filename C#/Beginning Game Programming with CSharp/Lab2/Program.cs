using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Lab2
{
    class Program
    {
        static void Main(string[] args)
        {
            int age = 37;
            
            Console.WriteLine("My age is " + age);
            Console.WriteLine();

            const int MAX_SCORE = 100;
            
            Random rnd1 = new Random();

            int score = rnd1.Next(MAX_SCORE);

            float percent = (float)score / MAX_SCORE;

            Console.WriteLine("Score percent is " + percent);
            Console.WriteLine();
        }
    }
}
