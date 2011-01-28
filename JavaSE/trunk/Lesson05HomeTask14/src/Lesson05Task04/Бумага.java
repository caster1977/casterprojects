/* Реализовать интерфейсы, а также наследование и полиморфизм для следующих классов:
14. interface Бумага  <- abstract class Тетрадь <- class Тетрадь Для Рисования. */

package Lesson05Task04;

public interface Бумага 
{
	int getДлина();
	int getШирина();
	String getЦвет();
	String getФормат(); 
	String getТип(); 
}
