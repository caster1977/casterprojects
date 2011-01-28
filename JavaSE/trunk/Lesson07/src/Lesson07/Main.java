package Lesson07;

import java.util.Scanner;

public class Main 
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		int i = 0, j = 0;
		boolean flag = false;
		
		while (! flag)
		{
			System.out.print("Введите первое число или нажмите Ctrl+Z для выхода: ");
			if (sc.hasNextInt())
			{
				flag = true;
				i = sc.nextInt();
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
			System.out.print("Введите второе число или нажмите Ctrl+Z для выхода: ");
			if (sc.hasNextInt())
			{
				flag = true;
				j = sc.nextInt();
			}
			else 
			{
				System.out.println("Ошибка: введено отличное от целочисленного значение!");
				sc.next();
			}
		}
		
		try
		{
			System.out.println(i/j);
		}
		catch (ArithmeticException e)
		{
			System.out.println(e.toString());
		}

		flag = false;
		
		while (! flag)
		{
			System.out.print("Введите число для деления или нажмите Ctrl+Z для выхода: ");
			if (sc.hasNextInt())
			{
				flag = true;
				i = sc.nextInt();
			}
			else 
			{
				System.out.println("Ошибка: введено отличное от целочисленного значение!");
				sc.next();
			}
		}
		sc.close();
		
		int [] IntArray = {5,7,3,11,2};
		for (int k = 0; k < IntArray.length; k++) 
		{
			try
			{
				System.out.println(IntArray[k]/i);
			}
			catch (ArithmeticException e)
			{
				System.out.println(e.toString());
			}			
		}
		
		int [] IntArray2 = {5,7,0,11};
		
		for (int k = 0; k < IntArray.length; k++) 
		{
			try
			{
				System.out.println(IntArray[k]/IntArray2[k]);
			}
			catch (ArithmeticException e)
			{
				System.out.println(e.toString());
			}					
			catch (ArrayIndexOutOfBoundsException e)
			{
				System.out.println(e.toString());
			}
		}	

		for (int k = 0; k < IntArray.length; k++) 
		{
			try
			{
				try
				{
					System.out.println(IntArray[k]/IntArray2[k]);
				}
				catch (ArithmeticException e)
				{
					throw new MyException();				
				}					
			}
			catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}	
	
	}
}
