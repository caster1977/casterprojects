/* Реализовать интерфейсы, а также наследование и полиморфизм для следующих классов:
14. interface Бумага  <- abstract class Тетрадь <- class Тетрадь Для Рисования. */

package Lesson05Task04;

public class Тетрадь_для_рисования extends Тетрадь 
{
	public Тетрадь_для_рисования() 
	{
		super();
	}

	public Тетрадь_для_рисования(int длина, int ширина, int количество_страниц, String цвет, String формат, String тип) 
	{
		super(длина, ширина, количество_страниц, цвет, формат, тип);
	}

	@Override
	public String toString() 
	{
		return "Тетрадь_для_рисования [getДлина()=" + getДлина()
				+ ", toString()=" + super.toString() + ", hashCode()="
				+ hashCode() + ", getКоличество_страниц()="
				+ getКоличество_страниц() + ", getШирина()=" + getШирина()
				+ ", getЦвет()=" + getЦвет() + ", getФормат()=" + getФормат()
				+ ", getТип()=" + getТип() + ", getClass()=" + getClass() + "]";
	}
}

