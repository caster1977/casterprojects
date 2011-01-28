package Lesson06;

import java.io.UnsupportedEncodingException;

public class Main 
{
	public static void main(String[] args) 
	{
		String s = new String();
		s = "Hello World";
		System.out.println(s);
		
		char chars[] = {'H','e','l','l','o',' ','W','o','r','l','d'};
		s = new String(chars);
		System.out.println(s);
		
		s = new String(chars,6,5);
		System.out.println(s);
		
		byte bytes[] = {'H','e','l','l','o',' ','W','o','r','l','d'};
		try 
		{
			s = new String(bytes,0,5,"cp1251");
			System.out.println(s);
		} 
		catch (UnsupportedEncodingException e) 
		{
			e.printStackTrace();
		}
		s = "строка";
		try 
		{
			String s1 = new String(s.getBytes("cp866"));
			System.out.println(s1);
		} catch (UnsupportedEncodingException e) 
		{
			e.printStackTrace();
		}
		System.out.println(s);
		
		s = "Эники беники ели вареники эники беники клец";
		System.out.println(s.length());
		
		String str1 = "строка";
		String str2 = "строка";
		String str3 = new String("строка");
		System.out.println(str1.equals(str2));
		System.out.println(str1.equals(str3));
		System.out.println(str2.equals(str3));
		System.out.println("");
		System.out.println(str1==str2);
		System.out.println(str1==str3);
		System.out.println(str2==str3);	
		System.out.println("");
		System.out.println(str1.intern()==str3.intern());
		System.out.println(1+2+3+"="+1+2+3);
		System.out.println(1+2+3+'='+1+2+3);
		System.out.println(1+2+3+"="+(1+2+3));
	}
}
