package Lesson10;

public class Main 
{
	public static float Calculate(Integer... number)
	{
		float i = 0;
		for (int j = 0; j < number.length; j++) 
			i+=number[j];			
		i=i/number.length;
		System.out.println(number.length);
		return i;
	}
	
	public static void main(String[] args) 
	{
		System.out.println(Calculate());
	}
}
