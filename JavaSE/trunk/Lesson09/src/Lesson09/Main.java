package Lesson09;

public class Main 
{
	public static void main(String[] args) 
	{
		/*
		Thread thread = Thread.currentThread();
		System.out.println(thread.getName());
		System.out.println(thread.getPriority());
		System.out.println(thread.isAlive());
		System.out.println(thread.isDaemon());
		*/
		
		Thread thread = new Thread(new RunnableDemo());
		thread.start(); // старт работы данного потока
		try 
		{
			thread.join(); // ожидание выполнения данного потока
		} 
		catch (InterruptedException e1) 
		{
			e1.printStackTrace();
		}
		
		System.out.println(Thread.currentThread().getName() + "1");

		ThreadDemo threadDemo = new ThreadDemo();
		threadDemo.start();

		try 
		{
			threadDemo.join(); // ожидание выполнения данного потока
		} 
		catch (InterruptedException e1) 
		{
			e1.printStackTrace();
		}
		
		System.out.println(Thread.currentThread().getName() + "2");
		
		try 
		{
			Thread.currentThread().sleep(3000);
		} 
		catch (InterruptedException e) 
		{
			e.printStackTrace();
		}
		
		System.out.println(Thread.currentThread().getName() + "3");
	}
}
