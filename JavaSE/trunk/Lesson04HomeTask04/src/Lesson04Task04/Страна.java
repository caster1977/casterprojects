package Lesson04Task04;

import java.util.Arrays;

public class Страна extends Область 
{
	private Область[] Области;
	public Страна(String название, String столица, long площадь) 
	{
		super(название, столица, площадь);
	}
	public Область[] getОбласти() {
		return Области;
	}
	public void setОбласти(Область[] области) {
		Области = области;
	}
	public int КоличествоОбластей()
	{
		return Области.length;
	}

	public void НапечататьКоличествоОбластей()
	{
		System.out.printf("Количество областей: %d\n", this.КоличествоОбластей());
	}

	public void НапечататьОбласти()
	{
		System.out.printf("\nОбласти:\n");
		for(int i=0;i<Области.length;i++)
		{
			System.out.printf(Области[i].toString()+"\n");
		}
	}
	public void НапечататьОбластныеЦентры()
	{
		System.out.printf("Областные центры: ");
		for(int i=0;i<Области.length;i++)
		{
			if ((i>0)&&(i<Области.length))
				System.out.print(", ");
			System.out.print(Области[i].getСтолица());
			if (i+1>=Области.length)
				System.out.print("\n");
		}
	}
	@Override
	public String toString() 
	{
		return "Страна - "+this.getНазвание()+"\nСтолица - "+this.getСтолица()+"\nПлощадь - "+this.getПлощадь()+" кв. км\nОбласти:\n" + Arrays.toString(Области);
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Arrays.hashCode(Области);
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		Страна other = (Страна) obj;
		if (!Arrays.equals(Области, other.Области))
			return false;
		return true;
	}
}
