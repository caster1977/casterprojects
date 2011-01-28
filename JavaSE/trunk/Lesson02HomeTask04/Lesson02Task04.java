import java.util.Scanner;

// ������� 4.
// ��������� ���� for ����������� ��������� ���������� ����� ����� 100..1. ���������� ��������� ���, ��� �� ������� ��������� ��� �������� ������������.

public class Lesson02Task04 
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		int start = 0, stop = 0;
		boolean flag = false;
		
		while (! flag)
		{
			System.out.print("������� ������ ��������� (����� �����) ��� ������� Ctrl+Z ��� ������: ");
			if (sc.hasNextInt())
			{
				flag = true;
				start = sc.nextInt();
			}
			else 
			{
				System.out.println("������: ������� �������� �� �������������� ��������!");
				sc.next();
			}
		}
		flag = false;
		while (! flag)
		{
			System.out.print("������� ����� ��������� (����� �����) ��� ������� Ctrl+Z ��� ������: ");
			if (sc.hasNextInt())
			{
				flag = true;
				stop = sc.nextInt();
			}
			else 
			{
				System.out.println("������: ������� �������� �� �������������� ��������!");
				sc.next();
			}
		}
		
		if (stop>start)
		{
			int change = stop;
			stop = start;
			start = change;
		}
		
		System.out.printf("\n����� ��������� ����� ��������� ������� �� ����� %d �� ����� %d.\n",start,stop);
		
		for (int i = start; i >= stop; i--)
		{
			System.out.printf("%d",i);
			if (i >= stop)
				System.out.print(" ");
			else System.out.print("\n");	
		}
	}
}
