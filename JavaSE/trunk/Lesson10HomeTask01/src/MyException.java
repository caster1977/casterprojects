public abstract class MyException extends Exception 
{
	public MyException() {
		super();
	}

	public MyException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public MyException(String arg0) {
		super(arg0);
	}

	public MyException(Throwable arg0) {
		super(arg0);
	}

	public abstract String toString();
}
