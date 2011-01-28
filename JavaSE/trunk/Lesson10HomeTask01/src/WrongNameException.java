
public class WrongNameException extends MyException {

	@Override
	public String toString() {
		return "Значение поля \"name\" не должно быть пустым!";
	}

}
