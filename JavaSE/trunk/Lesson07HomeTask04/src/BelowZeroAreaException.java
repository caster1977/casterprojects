public class BelowZeroAreaException extends MyException
{
	@Override
	public String toString() 
	{
		return "Площадь региона не может быть меньше нуля!";
	}
}
