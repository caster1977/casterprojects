package Lesson04Task04;

public class Область 
{
	private String Название;
	private String Столица;
	private long Площадь;
	
	public Область(String название, String столица, long площадь) {
		super();
		Название = название;
		Столица = столица;
		Площадь = площадь;
	}

	public String getНазвание() {
		return Название;
	}

	public void setНазвание(String название) {
		Название = название;
	}

	public String getСтолица() {
		return Столица;
	}

	public void setСтолица(String столица) {
		Столица = столица;
	}

	public long getПлощадь() {
		return Площадь;
	}

	public void setПлощадь(long площадь) {
		Площадь = площадь;
	}

	public void НапечататьСтолицу()
	{
		System.out.printf("Столица: %s\n", this.getСтолица());
	}

	public void НапечататьПлощадь()
	{
		System.out.printf("Площадь: %d кв. км\n", this.getПлощадь());
	}

	@Override
	public String toString() {
		return getНазвание() + " область: столица - " + getСтолица()
				+ ", площадь - " + getПлощадь() + " кв. км";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((Название == null) ? 0 : Название.hashCode());
		result = prime * result + (int) (Площадь ^ (Площадь >>> 32));
		result = prime * result + ((Столица == null) ? 0 : Столица.hashCode());
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
		Область other = (Область) obj;
		if (Название == null) {
			if (other.Название != null)
				return false;
		} else if (!Название.equals(other.Название))
			return false;
		if (Площадь != other.Площадь)
			return false;
		if (Столица == null) {
			if (other.Столица != null)
				return false;
		} else if (!Столица.equals(other.Столица))
			return false;
		return true;
	}

}
