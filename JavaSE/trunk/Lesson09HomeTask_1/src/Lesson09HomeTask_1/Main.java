/*
 * 
 *  
 *  СДКЛАЛ - КАК ПОНЯЛ, УЖ НЕ ОБЕССУДЬТЕ... Ж:(
 *  
 *  
 *  
Задание по многопоточному программированию:
Написать приложение, в котором используются потоки. 
Класс потока задать как наследник Thread.
Класс потока должен обеспечивать в методе run построчный несинхронизированный вывод в консольное окно 
чисел от 1 до 100 порциями по 10 чисел в строке, разделенных пробелами, причем перед каждой такой порцией 
должна стоять надпись "Thread 1:" для первого потока, "Thread 2:" — для второго и т.д.
Для вывода строки задать в классе метод print10().
В приложении при вводе с клавиатуры "createT" должны создаваться два или более потоков, а при вводе с клавиатуры "startT" они должны стартовать.
- Усовершенствовать приложение, обеспечив синхронизацию за счет объявления вызова print10() в методе run синхронизированным.
- Создать копию класса потока, отличающуюся от первоначальной тем, что выводятся числа от 101 до 200, 
класс задан как реализующий интерфейс Runnable, а метод print10() задан как синхронизированный. 
Добавить в приложение команды создание "createR" и старт "startR" потоков — экземпляров данного класса.
*/

package Lesson09HomeTask_1;

import java.util.ArrayList;
import java.util.Scanner;

public class Main 
{
	public static void main(String[] args) 
	{
		ArrayList<MyThread> myThreads = new ArrayList<MyThread>();
		
		// даём возможность пользователю выюрать язык 
		Scanner sc = new Scanner(System.in);
		int choise = 0;
		while (true)
		{
			System.out.print("Введите \"1\" для создания потока, \"2\" для запуска всех потоков, \"3\" для выхода из программы: ");
			if (sc.hasNextInt())
			{
				choise = sc.nextInt();
				switch (choise) 
				{
					case 1:
						System.out.println("\nСоздание потока № "+(myThreads.size()+1)+".");
						myThreads.add(new MyThread("Thread "+(myThreads.size()+1)));
						break;
					case 2:
						System.out.println("\nЗапуск потоков.\n");
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
						System.out.println("\nЗавершение работы программы по выбору пользователя.");
						sc.close();
						System.exit(0);
						break;
					default:
						System.out.println("Вы должны ввести число от \"1\" до \"3\"!");
						break;
				}				
			}
			else 
			{
				System.out.println("Ошибка: введено отличное от целочисленного значение!");
				sc.next();
			}
			System.out.println();
		}
	}
}
