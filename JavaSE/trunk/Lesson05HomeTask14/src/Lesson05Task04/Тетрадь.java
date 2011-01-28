/* Реализовать интерфейсы, а также наследование и полиморфизм для следующих классов:
14. interface Бумага  <- abstract class Тетрадь <- class Тетрадь Для Рисования. */

package Lesson05Task04;

public abstract class Тетрадь implements Бумага 
{
	private int Длина, Ширина, Количество_страниц;
	private String Цвет, Формат, Тип;

	@Override
	public int getДлина() 
	{
		return 0;
	}

	@Override
	public String toString() {
		return "Тетрадь [Длина=" + Длина + ", Ширина=" + Ширина
				+ ", Количество_страниц=" + Количество_страниц + ", Цвет="
				+ Цвет + ", Формат=" + Формат + ", Тип=" + Тип + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Длина;
		result = prime * result + Количество_страниц;
		result = prime * result + ((Тип == null) ? 0 : Тип.hashCode());
		result = prime * result + ((Формат == null) ? 0 : Формат.hashCode());
		result = prime * result + ((Цвет == null) ? 0 : Цвет.hashCode());
		result = prime * result + Ширина;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Тетрадь other = (Тетрадь) obj;
		if (Длина != other.Длина)
			return false;
		if (Количество_страниц != other.Количество_страниц)
			return false;
		if (Тип == null) {
			if (other.Тип != null)
				return false;
		} else if (!Тип.equals(other.Тип))
			return false;
		if (Формат == null) {
			if (other.Формат != null)
				return false;
		} else if (!Формат.equals(other.Формат))
			return false;
		if (Цвет == null) {
			if (other.Цвет != null)
				return false;
		} else if (!Цвет.equals(other.Цвет))
			return false;
		if (Ширина != other.Ширина)
			return false;
		return true;
	}

	public int getКоличество_страниц() {
		return Количество_страниц;
	}

	public void setКоличество_страниц(int количество_страниц) {
		Количество_страниц = количество_страниц;
	}

	public void setДлина(int длина) {
		Длина = длина;
	}

	public void setШирина(int ширина) {
		Ширина = ширина;
	}

	public void setЦвет(String цвет) {
		Цвет = цвет;
	}

	public Тетрадь() 
	{
		super();
	}

	public Тетрадь(int длина, int ширина, int количество_страниц, String цвет,
			String формат, String тип) 
	{
		super();
		Длина = длина;
		Ширина = ширина;
		Количество_страниц = количество_страниц;
		Цвет = цвет;
		Формат = формат;
		Тип = тип;
	}

	public void setФормат(String формат) {
		Формат = формат;
	}

	public void setТип(String тип) {
		Тип = тип;
	}

	public int getШирина() {
		return Ширина;
	}

	public String getЦвет() {
		return Цвет;
	}

	public String getФормат() {
		return Формат;
	}

	public String getТип() {
		return Тип;
	}


}
