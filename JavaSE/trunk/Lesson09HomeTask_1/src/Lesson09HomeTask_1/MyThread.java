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

	private synchronized void print10()
	{
		String string = this.name + ":\n";
		for (int j = 1; j <= 10; j++) 
		{
			string = string + (i*10+j);
			if (j<10)
				string = string + " ";
		}
		System.out.println(string);
		i++;
	}

	@Override
	public void run() 
	{
		super.run();
		Thread thread = Thread.currentThread();		
		thread.setName(name);
		while (i<10)
			print10();
	}
	
}
