
public class WrongParentIdException extends MyException {

	@Override
	public String toString() {
		return "Значение поля \"parent_id\" не должно быть меньше -1!";
	}

}
