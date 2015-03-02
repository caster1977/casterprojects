using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;

namespace Programming_Assignment_1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("This application will calculate the maximum height of the shell and the distance it will travel along the ground.");
            Console.WriteLine();
            Console.Write("Enter the initial angle in degrees: ");
            float theta = float.Parse(Console.ReadLine()); // initial angle you’ll ask the user to provide
            theta = (float)(theta * Math.PI / 180);
            Console.Write("Enter the initial speed: ");
            float speed = float.Parse(Console.ReadLine()); // initial speed you’ll ask the user to provide
            float vox = speed * (float)Math.Cos(theta); // x component of the velocity at start
            float voy = speed * (float)Math.Sin(theta); // y component of the velocity at start
            const float g = 9.8F; // acceleration due to gravity
            float t = voy / g; // time until shell reaches apex
            float h = voy * voy / (2 * g); // height of shell at apex
            float dx = vox * 2 * t; // distance shell travels horizontally (assuming launch and target elevations are equal)
            Console.WriteLine();
            Console.WriteLine("Height of shell at apex: " + h.ToString("F3", CultureInfo.CurrentCulture));
            Console.WriteLine("Distance shell travels horizontally (assuming launch and target elevations are equal: " + dx.ToString("F3", CultureInfo.CurrentCulture));
            Console.WriteLine();
        }
    }
}
