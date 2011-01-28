public class Область 
{
	private String Название;
	private String Столица;
	private long Площадь;
	
	public Область(String название, String столица, long площадь) throws MyException  
	{
		super();
		if (название.trim() == "")
			throw new EmptyNameException();
		else Название = название;
		if (столица.trim() == "")
			throw new EmptyCapitalException();
		else Столица = столица;
		if (площадь == 0)
			throw new ZeroAreaException();
		else 
			if (площадь < 0)
				throw new BelowZeroAreaException();
			else Площадь = площадь;
	}

	public void setНазвание(String название) throws EmptyNameException 
	{
		if (название.trim() == "")
			throw new EmptyNameException();
		else Название = название;
	}

	public void setСтолица(String столица) throws EmptyCapitalException  
	{
		if (столица.trim() == "")
			throw new EmptyCapitalException();
		else Столица = столица;
	}

	public void setПлощадь(long площадь) throws MyException 
	{
		if (площадь == 0)
			throw new ZeroAreaException();
		else 
			if (площадь < 0)
				throw new BelowZeroAreaException();
			else Площадь = площадь;	
	}

	public String getНазвание() {
		return Название;
	}

	public String getСтолица() {
		return Столица;
	}

	public long getПлощадь() {
		return Площадь;
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
