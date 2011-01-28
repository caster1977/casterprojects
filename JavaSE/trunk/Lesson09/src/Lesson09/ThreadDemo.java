package Lesson09;

public class ThreadDemo extends Thread 
{
	@Override
	public void run() 
	{
		Thread thread = Thread.currentThread();
		thread.setName("\"ThreadDemo\"");
		for (int i = 0; i < 10; i++) 
		{
			for (int j = 0; j < 100; j++) 
			{
				System.out.println(thread.getName() + " - public void run()"+ (i*100+j));
			}
			try 
			{
				thread.sleep(100);
			} 
			catch (InterruptedException e) 
			{
				e.printStackTrace();
			}
		}		
	}	
}
