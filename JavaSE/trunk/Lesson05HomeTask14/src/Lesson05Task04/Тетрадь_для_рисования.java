/* ����������� ����������, � ����� ������������ � ����������� ��� ��������� �������:
14. interface ������  <- abstract class ������� <- class ������� ��� ���������. */

package Lesson05Task04;

public class �������_���_��������� extends ������� 
{
	public �������_���_���������() 
	{
		super();
	}

	public �������_���_���������(int �����, int ������, int ����������_�������, String ����, String ������, String ���) 
	{
		super(�����, ������, ����������_�������, ����, ������, ���);
	}

	@Override
	public String toString() 
	{
		return "�������_���_��������� [get�����()=" + get�����()
				+ ", toString()=" + super.toString() + ", hashCode()="
				+ hashCode() + ", get����������_�������()="
				+ get����������_�������() + ", get������()=" + get������()
				+ ", get����()=" + get����() + ", get������()=" + get������()
				+ ", get���()=" + get���() + ", getClass()=" + getClass() + "]";
	}
}

