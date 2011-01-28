public class WrongIdException extends MyException {

	@Override
	public String toString() {
		return "Значение поля \"id\" не должно быть меньше нуля!";
	}

}
