package Lesson07;

public class MyException extends Exception 
{

	public MyException() 
	{
		super();
	}

	public MyException(String message, Throwable cause) 
	{
		super(message, cause);
	}

	public MyException(String message) 
	{
		super(message);
	}

	public MyException(Throwable cause) 
	{
		super(cause);
	}
	
	@Override
	public String toString() 
	{
		return "Мой класс исключения";
	}
}
