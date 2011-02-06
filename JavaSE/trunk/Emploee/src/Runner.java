import javax.swing.SwingUtilities;


public class Runner {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
			@Override
			public void run() {
				new UserAuthentication();
			}
		});
	}
}
