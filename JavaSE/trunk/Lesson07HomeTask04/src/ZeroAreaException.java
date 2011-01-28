public class ZeroAreaException extends MyException
{
	@Override
	public String toString() 
	{
		return "Площадь региона не может быть равна нулю!";
	}
}
