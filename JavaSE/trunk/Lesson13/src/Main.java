import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.Toolkit;
import java.awt.Window;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.border.Border;

public class Main extends JFrame 
{
	JLabel label;
	JButton buton;
	JTextField textField;
	
	public Main()	
	{
		JFrame frame = new JFrame("Hello, world!");
		frame.setDefaultCloseOperation(EXIT_ON_CLOSE);
		Toolkit toolkit = Toolkit.getDefaultToolkit();
		Dimension dimension = toolkit.getScreenSize();
		
		frame.setSize(dimension.width/2, dimension.height/2);
		frame.setLocation((dimension.width-dimension.width/2)/2,(dimension.height-dimension.height/2)/2);
		FlowLayout layout = new FlowLayout();
		//frame.setLayout(layout);
		
		GridLayout gridLayout = new GridLayout(5,2,2,2);
		frame.setLayout(gridLayout);
		
		label = new JLabel("Hello");
		buton = new JButton("Hello");
		textField = new JTextField("Hello");
		frame.add(label);
		frame.add(buton);
		frame.add(textField);
		
		
		
		frame.setVisible(true);
	}

	public static void main(String[] args) 
	{
		SwingUtilities.invokeLater
		(
			new Runnable()
			{
				public void run()
				{
					new Main();				
				}
			}
		);
	}
}
