/* Реализовать интерфейсы, а также наследование и полиморфизм для следующих классов:
14. interface Бумага  <- abstract class Тетрадь <- class Тетрадь Для Рисования. */

package Lesson05Task04;

public class Main 
{
	public static void main(String[] args) 
	{
		Тетрадь_для_рисования a = new Тетрадь_для_рисования(12,20,20,"белый","A4","матовая, немелованная");
		System.out.println(a.toString());	
	}
}
