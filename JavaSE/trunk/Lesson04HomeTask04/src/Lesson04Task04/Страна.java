package Lesson04Task04;

import java.util.Arrays;

public class ������ extends ������� 
{
	private �������[] �������;
	public ������(String ��������, String �������, long �������) 
	{
		super(��������, �������, �������);
	}
	public �������[] get�������() {
		return �������;
	}
	public void set�������(�������[] �������) {
		������� = �������;
	}
	public int ������������������()
	{
		return �������.length;
	}

	public void ����������������������������()
	{
		System.out.printf("���������� ��������: %d\n", this.������������������());
	}

	public void �����������������()
	{
		System.out.printf("\n�������:\n");
		for(int i=0;i<�������.length;i++)
		{
			System.out.printf(�������[i].toString()+"\n");
		}
	}
	public void �������������������������()
	{
		System.out.printf("��������� ������: ");
		for(int i=0;i<�������.length;i++)
		{
			if ((i>0)&&(i<�������.length))
				System.out.print(", ");
			System.out.print(�������[i].get�������());
			if (i+1>=�������.length)
				System.out.print("\n");
		}
	}
	@Override
	public String toString() 
	{
		return "������ - "+this.get��������()+"\n������� - "+this.get�������()+"\n������� - "+this.get�������()+" ��. ��\n�������:\n" + Arrays.toString(�������);
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Arrays.hashCode(�������);
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
		������ other = (������) obj;
		if (!Arrays.equals(�������, other.�������))
			return false;
		return true;
	}
}
