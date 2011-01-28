package MyPackage;

public class ClassDemo 
{
	// объявление переменных
	private static int staticField;
	private int dinamicField;
	// блок статической инициализации
	static 
	{
		staticField = 10;
		System.out.printf("Блок статической инициализации.\nЗначение переменной staticField = %d.\n", staticMethod());
	}
	// блок динамической инициализации
	{
		dinamicField = 15;
		System.out.printf("Блок динамической инициализации класса \""+this.getClass().getName()+"\".\nЗначение переменной dinamicField = %d.\n", dinamicField);
	}
	public ClassDemo() 
	{
		super();
		System.out.printf("Блок конструктора по умолчанию класса \""+this.getClass().getName()+"\".\nЗначение переменной staticField = %d.\nЗначение переменной dinamicField = %d.\n", dinamicField);
	}
	
	public ClassDemo(int dinamicField) {
		super();
		this.dinamicField = dinamicField;
		System.out.printf("Блок конструктора класса \""+this.getClass().getName()+"\".\nЗначение переменной staticField = %d.\nЗначение переменной dinamicField = %d.\n", staticField, dinamicField);
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
