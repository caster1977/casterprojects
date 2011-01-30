import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.UIManager.LookAndFeelInfo;

public class Main extends JFrame  
{
	private static final long serialVersionUID = 6048003226374008546L;
	
	JLabel label;
	JButton buton;
	JTextField textField;
	
	public Main()	
	{
		try 
		{
		    UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
		    SwingUtilities.updateComponentTreeUI(this);
		} 
		catch (Exception e) 
		{
		    System.err.println("Cannot set look and feel: " + e.getMessage());
		}

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
		buton.addMouseListener(
			new	MouseAdapter() 
			{
				@Override
				public void mouseClicked(MouseEvent e) 
				{
					label.setText("mouseClicked");
				}
			}
		);
		textField = new JTextField("Hello");
		frame.add(label);
		frame.add(buton);
		frame.add(textField);
		
		frame.setVisible(true);
	}

	public static void main(String[] args) 
	{
		try 
		{
			LookAndFeelInfo[] lookAndFeels = UIManager.getInstalledLookAndFeels();
			for (LookAndFeelInfo lookAndFeelInfo : lookAndFeels) 
			{
				System.out.println(lookAndFeelInfo.toString());
			}
		} 
		catch (Exception e) 
		{
		    System.err.println("Cannot set look and feel: " + e.getMessage());
		}

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
