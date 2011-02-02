package Lesson09HomeTask_1;

public class MyThread extends Thread 
{
	private Integer i = 0;
	private String name = "";
	
	public MyThread(String name) 
	{
		super();
		this.name = name; 
	}

	private void print10()
	{
		for (int j = 1; j <= 10; j++) 
		{
			System.out.print(i*10+j);
			if (j<10)
				System.out.print(" ");
		}
		System.out.println();
		i++;
	}

	@Override
	public void run() 
	{
		super.run();
		Thread thread = Thread.currentThread();		
		thread.setName(name);
		while (i<10)
		{
			System.out.println(thread.getName() + ":");
			print10();
		}		
	}
	
}
