import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;


public class UserAuthentication extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * ��� ����, ����� ������������ ���������� � ����������� ��������� �����,
	 * ������������� ������� �� ������� ������ ����
	 */
	JTextField loginField;
	JPasswordField passwordField;
	JLabel loginLabel;
	JLabel passwordLabel;
	JButton ok;
	JButton cancel;
	private String user = "";
	private String password = "";
	JFrame frame = new JFrame("���� � �������");
	UserAuthentication() {
		//super("���� � �������");
		frame.setDefaultCloseOperation(EXIT_ON_CLOSE);
		// ����������� ������ �������������� ������ (��� ����� ������)
		Box box1 = Box.createHorizontalBox();
		loginLabel = new JLabel("�����:");
		loginField = new JTextField(15);
		box1.add(loginLabel);
		box1.add(Box.createHorizontalStrut(6));
		box1.add(loginField);
		// ����������� ������ �������������� ������ (��� ���� ������)
		Box box2 = Box.createHorizontalBox();
		passwordLabel = new JLabel("������:");
		passwordField = new JPasswordField(15);
		box2.add(passwordLabel);
		box2.add(Box.createHorizontalStrut(6));
		box2.add(passwordField);
		// ����������� ������ �������������� ������ (� ��������)
		Box box3 = Box.createHorizontalBox();
		ok = new JButton("OK");
		cancel = new JButton("������");
		ok.addActionListener(new ActionListener(){
			@Override
			public void actionPerformed(ActionEvent arg0) {
				// TODO Auto-generated method stub
				user = loginField.getText().trim();
				password = passwordField.getText().trim();
				if(user.equals("user")&&password.equals("pass")){
						new SQLConnectionFrame();
						frame.setVisible(false);
				}
				else JOptionPane.showMessageDialog(null,
					  "��� ������������ ��� ������ ������� �� �����",
					  "������ ��� �����������",
					  JOptionPane.ERROR_MESSAGE);				
			}});
		cancel.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				// TODO Auto-generated method stub
				System.exit(0);
			}
		});	
		box3.add(Box.createHorizontalGlue());
		box3.add(ok);
		box3.add(Box.createHorizontalStrut(12));
		box3.add(cancel);
		// �������� ������� �����������
		loginLabel.setPreferredSize(passwordLabel.getPreferredSize());
		// ��������� ��� �������������� ������ �� ����� ������������
		Box mainBox = Box.createVerticalBox();
		mainBox.setBorder(new EmptyBorder(12, 12, 12, 12));
		mainBox.add(box1);
		mainBox.add(Box.createVerticalStrut(12));
		mainBox.add(box2);
		mainBox.add(Box.createVerticalStrut(17));
		mainBox.add(box3);
		frame.setContentPane(mainBox);
		frame.pack();
		frame.setLocationRelativeTo(null);
		frame.setResizable(false);
		frame.setVisible(true);
	}

	public String getUser() {
		return user;
	}

	public String getPassword() {
		return password;
	}
}
