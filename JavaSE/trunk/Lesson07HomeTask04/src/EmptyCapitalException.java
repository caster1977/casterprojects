public class EmptyCapitalException extends MyException
{
	@Override
	public String toString() 
	{
		return "Строка названия столицы региона не может быть пустой!";
	}
}
