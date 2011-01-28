public class ������� 
{
	private String ��������;
	private String �������;
	private long �������;
	
	public �������(String ��������, String �������, long �������) throws MyException  
	{
		super();
		if (��������.trim() == "")
			throw new EmptyNameException();
		else �������� = ��������;
		if (�������.trim() == "")
			throw new EmptyCapitalException();
		else ������� = �������;
		if (������� == 0)
			throw new ZeroAreaException();
		else 
			if (������� < 0)
				throw new BelowZeroAreaException();
			else ������� = �������;
	}

	public void set��������(String ��������) throws EmptyNameException 
	{
		if (��������.trim() == "")
			throw new EmptyNameException();
		else �������� = ��������;
	}

	public void set�������(String �������) throws EmptyCapitalException  
	{
		if (�������.trim() == "")
			throw new EmptyCapitalException();
		else ������� = �������;
	}

	public void set�������(long �������) throws MyException 
	{
		if (������� == 0)
			throw new ZeroAreaException();
		else 
			if (������� < 0)
				throw new BelowZeroAreaException();
			else ������� = �������;	
	}

	public String get��������() {
		return ��������;
	}

	public String get�������() {
		return �������;
	}

	public long get�������() {
		return �������;
	}

	public void �����������������()
	{
		System.out.printf("�������: %s\n", this.get�������());
	}

	public void �����������������()
	{
		System.out.printf("�������: %d ��. ��\n", this.get�������());
	}

	@Override
	public String toString() {
		return get��������() + " �������: ������� - " + get�������()
				+ ", ������� - " + get�������() + " ��. ��";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((�������� == null) ? 0 : ��������.hashCode());
		result = prime * result + (int) (������� ^ (������� >>> 32));
		result = prime * result + ((������� == null) ? 0 : �������.hashCode());
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
		������� other = (�������) obj;
		if (�������� == null) {
			if (other.�������� != null)
				return false;
		} else if (!��������.equals(other.��������))
			return false;
		if (������� != other.�������)
			return false;
		if (������� == null) {
			if (other.������� != null)
				return false;
		} else if (!�������.equals(other.�������))
			return false;
		return true;
	}

}
