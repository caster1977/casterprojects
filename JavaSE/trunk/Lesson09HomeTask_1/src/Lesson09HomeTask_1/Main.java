/*
 * 
 *  
 *  ������ - ��� �����, �� �� ����������... �:(
 *  
 *  
 *  
������� �� �������������� ����������������:
�������� ����������, � ������� ������������ ������. 
����� ������ ������ ��� ��������� Thread.
����� ������ ������ ������������ � ������ run ���������� �������������������� ����� � ���������� ���� 
����� �� 1 �� 100 �������� �� 10 ����� � ������, ����������� ���������, ������ ����� ������ ����� ������� 
������ ������ ������� "Thread 1:" ��� ������� ������, "Thread 2:" � ��� ������� � �.�.
��� ������ ������ ������ � ������ ����� print10().
� ���������� ��� ����� � ���������� "createT" ������ ����������� ��� ��� ����� �������, � ��� ����� � ���������� "startT" ��� ������ ����������.
- ����������������� ����������, ��������� ������������� �� ���� ���������� ������ print10() � ������ run ������������������.
- ������� ����� ������ ������, ������������ �� �������������� ���, ��� ��������� ����� �� 101 �� 200, 
����� ����� ��� ����������� ��������� Runnable, � ����� print10() ����� ��� ������������������. 
�������� � ���������� ������� �������� "createR" � ����� "startR" ������� � ����������� ������� ������.
*/

package Lesson09HomeTask_1;

import java.util.ArrayList;
import java.util.Scanner;

public class Main 
{
	public static void main(String[] args) 
	{
		ArrayList<MyThread> myThreads = new ArrayList<MyThread>();
		
		// ��� ����������� ������������ ������� ���� 
		Scanner sc = new Scanner(System.in);
		int choise = 0;
		while (true)
		{
			System.out.print("������� \"1\" ��� �������� ������, \"2\" ��� ������� ���� �������, \"3\" ��� ������ �� ���������: ");
			if (sc.hasNextInt())
			{
				choise = sc.nextInt();
				switch (choise) 
				{
					case 1:
						System.out.println("\n�������� ������ � "+(myThreads.size()+1)+".");
						myThreads.add(new MyThread("Thread "+(myThreads.size()+1)));
						break;
					case 2:
						System.out.println("\n������ �������.\n");
						for (MyThread myThread : myThreads) 
						{
							myThread.start();
						}
						
						myThreads = new ArrayList<MyThread>();

						try 
						{
							Thread.currentThread().sleep(1000);
						} 
						catch (InterruptedException e) 
						{
							e.printStackTrace();
						}

						break;
					case 3:
						System.out.println("\n���������� ������ ��������� �� ������ ������������.");
						sc.close();
						System.exit(0);
						break;
					default:
						System.out.println("�� ������ ������ ����� �� \"1\" �� \"3\"!");
						break;
				}				
			}
			else 
			{
				System.out.println("������: ������� �������� �� �������������� ��������!");
				sc.next();
			}
			System.out.println();
		}
	}
}
