package Lesson10;

import java.util.ArrayList;
import java.util.Iterator;

public class GenericDemo <T /*extends Number*/> // V E K 
{
	T object;
	
	public GenericDemo(T object) 
	{
		super();
		this.object = object;
	}

	@Override
	public String toString() 
	{
		return object.getClass().getName();
	}

	public static void main(String[] args) 
	{
		System.out.println(new GenericDemo<Integer>(5).toString());		
		System.out.println(new GenericDemo<String>("Hello, world!").toString());		
		System.out.println(new GenericDemo<Double>(5.0).toString());		
		System.out.println(new GenericDemo<Character>('W').toString());
		System.out.println(new GenericDemo<Object>(new Object()).toString());
		
		ArrayList<String> sl = new ArrayList<String>();
		for (Integer i = 0; i < 10; i++) 
			sl.add(i.toString());
		
		for (Iterator<String> iterator = sl.iterator(); iterator.hasNext();) 
			System.out.println((String) iterator.next());
		
		for (int i = 0; i < sl.size(); i++) 
			System.out.println(sl.get(i));

		for (String string : sl) 
			System.out.println(string);
	}
}
