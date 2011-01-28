import java.util.Scanner;

// Вариант 4.
// Используя цикл for реализовать программу печатающую целые числа 100..1. Доработать программу так, что бы границы диапазона мог задавать пользователь.

public class Lesson02Task04 
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		int start = 0, stop = 0;
		boolean flag = false;
		
		while (! flag)
		{
			System.out.print("Введите начало диапазона (целое число) или нажмите Ctrl+Z для выхода: ");
			if (sc.hasNextInt())
			{
				flag = true;
				start = sc.nextInt();
			}
			else 
			{
				System.out.println("Ошибка: введено отличное от целочисленного значение!");
				sc.next();
			}
		}
		flag = false;
		while (! flag)
		{
			System.out.print("Введите конец диапазона (целое число) или нажмите Ctrl+Z для выхода: ");
			if (sc.hasNextInt())
			{
				flag = true;
				stop = sc.nextInt();
			}
			else 
			{
				System.out.println("Ошибка: введено отличное от целочисленного значение!");
				sc.next();
			}
		}
		
		if (stop>start)
		{
			int change = stop;
			stop = start;
			start = change;
		}
		
		System.out.printf("\nБудет произведён вывод числового порядка от числа %d до числа %d.\n",start,stop);
		
		for (int i = start; i >= stop; i--)
		{
			System.out.printf("%d",i);
			if (i >= stop)
				System.out.print(" ");
			else System.out.print("\n");	
		}
	}
}
