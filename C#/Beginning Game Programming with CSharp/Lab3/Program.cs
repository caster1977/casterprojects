using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Lab3
{
    class Program
    {
        static void Main(string[] args)
        {
            float originalFahrenheit, calculatedCelsius, calculatedFahrenheit;
            
            Console.Write("Enter temperature (Fahrenheit): ");
            originalFahrenheit = float.Parse(Console.ReadLine());

            calculatedCelsius = (originalFahrenheit - (float)32) / (float)9 * (float)5;
            calculatedFahrenheit = calculatedCelsius * (float)9 / (float)5 + (float)32;

            Console.WriteLine(originalFahrenheit + " degrees Fahrenheit is " + calculatedCelsius + " degrees Celsius");
            Console.WriteLine(calculatedCelsius + " degrees Celsius is " + calculatedFahrenheit + " degrees Fahrenheit");
        }
    }
}
