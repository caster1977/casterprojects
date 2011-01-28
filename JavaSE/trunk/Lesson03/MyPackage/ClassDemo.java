package MyPackage;

public class ClassDemo 
{
	// ���������� ����������
	private static int staticField;
	private int dinamicField;
	// ���� ����������� �������������
	static 
	{
		staticField = 10;
		System.out.printf("���� ����������� �������������.\n�������� ���������� staticField = %d.\n", staticMethod());
	}
	// ���� ������������ �������������
	{
		dinamicField = 15;
		System.out.printf("���� ������������ ������������� ������ \""+this.getClass().getName()+"\".\n�������� ���������� dinamicField = %d.\n", dinamicField);
	}
	public ClassDemo() 
	{
		super();
		System.out.printf("���� ������������ �� ��������� ������ \""+this.getClass().getName()+"\".\n�������� ���������� staticField = %d.\n�������� ���������� dinamicField = %d.\n", dinamicField);
	}
	
	public ClassDemo(int dinamicField) {
		super();
		this.dinamicField = dinamicField;
		System.out.printf("���� ������������ ������ \""+this.getClass().getName()+"\".\n�������� ���������� staticField = %d.\n�������� ���������� dinamicField = %d.\n", staticField, dinamicField);
	}

	public static int staticMethod()
	{
		return staticField;
	}
	public int dinamicMethod()
	{
		return dinamicField;
	}
	
}
