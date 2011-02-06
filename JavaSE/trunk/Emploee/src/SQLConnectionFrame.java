import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.IOException;
import java.sql.SQLException;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTable;


public class SQLConnectionFrame extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	SQLConnectionFrame(){
		JFrame frame = new JFrame("SQLConnectionFrame");
		frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		frame.addWindowListener(new WindowAdapter() {
			 public void windowClosing(WindowEvent e) {
				 Object[] options = { "��", "���!" };
				 int n = JOptionPane
				 .showOptionDialog(e.getWindow(), "������� ����?",
				 "�������������", JOptionPane.YES_NO_OPTION,
				 JOptionPane.QUESTION_MESSAGE, null, options,
				 options[0]);
				 if (n == 0) {
					 e.getWindow().setVisible(false);
					 System.exit(0);
				 }
			 }
		});
		Toolkit toolkit = Toolkit.getDefaultToolkit();
		Dimension dimension = toolkit.getScreenSize();
		//frame.setLocation(dimension.width/4, dimension.height/4);
		frame.setSize(dimension.width/2, dimension.height/2);
		SQLConnection sqlConnection = null;
		try {
			sqlConnection = new SQLConnection("SELECT * FROM emp");
			//throw new ClassNotFoundException("�� ������ ����� ��������");
			//throw new SQLException("�� ������� ����������� � ���� ������");
			//throw new IOException("�� ������ ���� ��������");
		} catch (ClassNotFoundException e) {
			JOptionPane.showMessageDialog(null,
										  "�� ������ ����� ��������",
										  "������ ��� �������� ��������",
										  JOptionPane.ERROR_MESSAGE);
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(null,
					  "�� ������� ����������� � ���� ������",
					  "������ ��� ������ � ����� ������",
					  JOptionPane.ERROR_MESSAGE);
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null,
					  "�� ������ ���� ��������",
					  "������ ��� ��������� � ����� ��������",
					  JOptionPane.ERROR_MESSAGE);
		}
		
		JTable jTable = null;
		try {
			jTable = new JTable(sqlConnection.getRowData(),sqlConnection.getColumnName());
			//throw new SQLException();
		} catch (SQLException e) {
			JOptionPane.showMessageDialog(null,
					  "�� ������� ��������� SQL ������",
					  "������ ��� ���������� SQL �������",
					  JOptionPane.ERROR_MESSAGE);
		}
		
		JScrollPane jScrollPane = new JScrollPane(jTable);
		jScrollPane.revalidate();
		frame.add(jScrollPane);
		Dimension dimension2 = new Dimension(dimension.width/2, dimension.height/2);
		
		frame.setPreferredSize(dimension2);
		frame.pack();
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);
	}
}
