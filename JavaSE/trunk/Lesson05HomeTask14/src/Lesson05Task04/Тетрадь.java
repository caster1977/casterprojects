/* ����������� ����������, � ����� ������������ � ����������� ��� ��������� �������:
14. interface ������  <- abstract class ������� <- class ������� ��� ���������. */

package Lesson05Task04;

public abstract class ������� implements ������ 
{
	private int �����, ������, ����������_�������;
	private String ����, ������, ���;

	@Override
	public int get�����() 
	{
		return 0;
	}

	@Override
	public String toString() {
		return "������� [�����=" + ����� + ", ������=" + ������
				+ ", ����������_�������=" + ����������_������� + ", ����="
				+ ���� + ", ������=" + ������ + ", ���=" + ��� + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + �����;
		result = prime * result + ����������_�������;
		result = prime * result + ((��� == null) ? 0 : ���.hashCode());
		result = prime * result + ((������ == null) ? 0 : ������.hashCode());
		result = prime * result + ((���� == null) ? 0 : ����.hashCode());
		result = prime * result + ������;
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
		if (����� != other.�����)
			return false;
		if (����������_������� != other.����������_�������)
			return false;
		if (��� == null) {
			if (other.��� != null)
				return false;
		} else if (!���.equals(other.���))
			return false;
		if (������ == null) {
			if (other.������ != null)
				return false;
		} else if (!������.equals(other.������))
			return false;
		if (���� == null) {
			if (other.���� != null)
				return false;
		} else if (!����.equals(other.����))
			return false;
		if (������ != other.������)
			return false;
		return true;
	}

	public int get����������_�������() {
		return ����������_�������;
	}

	public void set����������_�������(int ����������_�������) {
		����������_������� = ����������_�������;
	}

	public void set�����(int �����) {
		����� = �����;
	}

	public void set������(int ������) {
		������ = ������;
	}

	public void set����(String ����) {
		���� = ����;
	}

	public �������() 
	{
		super();
	}

	public �������(int �����, int ������, int ����������_�������, String ����,
			String ������, String ���) 
	{
		super();
		����� = �����;
		������ = ������;
		����������_������� = ����������_�������;
		���� = ����;
		������ = ������;
		��� = ���;
	}

	public void set������(String ������) {
		������ = ������;
	}

	public void set���(String ���) {
		��� = ���;
	}

	public int get������() {
		return ������;
	}

	public String get����() {
		return ����;
	}

	public String get������() {
		return ������;
	}

	public String get���() {
		return ���;
	}


}
