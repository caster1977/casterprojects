import javax.swing.SwingUtilities;
import java.awt.BorderLayout;
import javax.swing.JPanel;
import javax.swing.JFrame;
import java.awt.Dimension;
import javax.swing.JButton;
import java.awt.Rectangle;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;

import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JSeparator;
import javax.swing.JEditorPane;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JFileChooser;

public class Main extends JFrame {

	private static final long serialVersionUID = 1L;
	private File workFile = null; 
	private JPanel jContentPane = null;
	private JMenuBar jJMenuBar = null;
	private JMenu jMenu = null;
	private JMenu jMenu1 = null;
	private JMenu jMenu2 = null;
	private JMenuItem jMenuItem = null;
	private JMenuItem jMenuItem1 = null;
	private JMenuItem jMenuItem2 = null;
	private JMenuItem jMenuItem3 = null;
	private JMenuItem jMenuItem4 = null;
	private JMenuItem jMenuItem5 = null;
	private JSeparator jSeparator = null;
	private JMenuItem jMenuItem6 = null;
	private JMenuItem jMenuItem7 = null;
	private JMenuItem jMenuItem8 = null;
	private JMenuItem jMenuItem9 = null;
	private JMenuItem jMenuItem11 = null;
	private JMenuItem jMenuItem12 = null;
	private JScrollPane jScrollPane = null;
	private JTextArea jTextArea = null;
	private JFileChooser jFileChooser = null;  //  @jve:decl-index=0:visual-constraint="206,338"
	
	private void WriteOpenedFile(File output_file)
	{
		if (jTextArea.getLineCount()>0)
		{
			FileWriter fileWriter = null;
			BufferedWriter bufferedWriter = null;
	
			try 
			{
				fileWriter = new FileWriter(output_file);
				bufferedWriter = new BufferedWriter(fileWriter);
				
				bufferedWriter.write(jTextArea.getText());
				//bufferedWriter.newLine();

				bufferedWriter.flush();
				System.out.println("Результирующий файл успешно записан.");
				bufferedWriter.close();
				fileWriter.close();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
		}
	}

	private void ReadOpenedFile(File input_file)
	{
		FileReader fileReader = null;
		BufferedReader bufferedReader = null;

		try 
		{
			fileReader = new FileReader(input_file);
			bufferedReader = new BufferedReader(fileReader);

			boolean eof = false;
			while (!eof) 
			{
				String line = "";
				try 
				{
					line = bufferedReader.readLine();
				} 
				catch (IOException e) 
				{
					e.printStackTrace();
				}
				if (line == null)
					eof = true;
				else
				{
					jTextArea.append(line+"\n");
				}
			}
			System.out.println("Исходный файл успешно прочитан.");
			try 
			{
				bufferedReader.close();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			try 
			{
				fileReader.close();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
		} 
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();
		}
	}
	
	
	private JMenuBar getJJMenuBar() {
		if (jJMenuBar == null) {
			jJMenuBar = new JMenuBar();
			jJMenuBar.add(getJMenu());
			jJMenuBar.add(getJMenu1());
			jJMenuBar.add(getJMenu2());
		}
		return jJMenuBar;
	}

	private JMenu getJMenu() {
		if (jMenu == null) {
			jMenu = new JMenu();
			jMenu.setText("File");
			jMenu.add(getJMenuItem());
			jMenu.add(getJMenuItem1());
			jMenu.add(getJMenuItem2());
			jMenu.add(getJMenuItem3());
			jMenu.add(getJMenuItem4());
			jMenu.add(getJSeparator());
			jMenu.add(getJMenuItem5());
		}
		return jMenu;
	}

	private JMenu getJMenu1() {
		if (jMenu1 == null) {
			jMenu1 = new JMenu();
			jMenu1.setText("Action");
			jMenu1.add(getJMenuItem7());
			jMenu1.add(getJMenuItem6());
			jMenu1.add(getJMenuItem8());
			jMenu1.add(getJMenuItem9());
		}
		return jMenu1;
	}

	private JMenu getJMenu2() {
		if (jMenu2 == null) {
			jMenu2 = new JMenu();
			jMenu2.setText("?");
			jMenu2.add(getJMenuItem11());
			jMenu2.add(getJMenuItem12());
		}
		return jMenu2;
	}

	private JMenuItem getJMenuItem() {
		if (jMenuItem == null) {
			jMenuItem = new JMenuItem();
			jMenuItem.setText("New");
			jMenuItem.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					workFile = null;
					jTextArea.setText("");
					jTextArea.setVisible(true);					
					jMenuItem2.setEnabled(true);
					jMenuItem3.setEnabled(true);
					jMenuItem4.setEnabled(true);
					jMenu1.setEnabled(true);
				}
			});
		}
		return jMenuItem;
	}

	private JMenuItem getJMenuItem1() {
		if (jMenuItem1 == null) {
			jMenuItem1 = new JMenuItem();
			jMenuItem1.setText("Open...");
			jMenuItem1.addActionListener(
				new java.awt.event.ActionListener() 
				{
					public void actionPerformed(java.awt.event.ActionEvent e) 
					{
						getJFileChooser().setMultiSelectionEnabled(false);
						getJFileChooser().showOpenDialog(jContentPane);
						workFile = getJFileChooser().getSelectedFile();
						if (workFile.exists() && workFile.isFile())
						{
							jTextArea.setText("");
							ReadOpenedFile(workFile);
							jTextArea.setVisible(true);
							jMenuItem2.setEnabled(true);
							jMenuItem3.setEnabled(true);
							jMenuItem4.setEnabled(true);
							jMenu1.setEnabled(true);
						}
						else
						{
							System.out.println("Исходный файл не найден!");
						}
					}
				}
			);
		}
		return jMenuItem1;
	}

	private JMenuItem getJMenuItem2() {
		if (jMenuItem2 == null) {
			jMenuItem2 = new JMenuItem();
			jMenuItem2.setText("Save");
			jMenuItem2.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					if (workFile!=null)
					{
						if (workFile.exists() && workFile.isFile())
						{
							WriteOpenedFile(workFile);
						}
						else
						{
							getJFileChooser().setMultiSelectionEnabled(false);
							getJFileChooser().showSaveDialog(jContentPane);
							workFile = getJFileChooser().getSelectedFile();
							WriteOpenedFile(workFile);
						}
					}
					else
					{
						getJFileChooser().setMultiSelectionEnabled(false);
						getJFileChooser().showSaveDialog(jContentPane);
						workFile = getJFileChooser().getSelectedFile();
						WriteOpenedFile(workFile);
					}
				}
			});
		}
		return jMenuItem2;
	}

	private JMenuItem getJMenuItem3() {
		if (jMenuItem3 == null) {
			jMenuItem3 = new JMenuItem();
			jMenuItem3.setText("Save as...");
			jMenuItem3.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					getJFileChooser().setMultiSelectionEnabled(false);
					getJFileChooser().showSaveDialog(jContentPane);
					workFile = getJFileChooser().getSelectedFile();
					WriteOpenedFile(workFile);
				}
			});
		}
		return jMenuItem3;
	}

	private JMenuItem getJMenuItem4() {
		if (jMenuItem4 == null) {
			jMenuItem4 = new JMenuItem();
			jMenuItem4.setText("Close");
			jMenuItem4.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					jTextArea.setVisible(false);
					jTextArea.setText("");
					jMenuItem2.setEnabled(false);
					jMenuItem3.setEnabled(false);
					jMenuItem4.setEnabled(false);
					jMenu1.setEnabled(false);
				}
			});
		}
		return jMenuItem4;
	}

	private JMenuItem getJMenuItem5() {
		if (jMenuItem5 == null) {
			jMenuItem5 = new JMenuItem();
			jMenuItem5.setText("Quit");
			jMenuItem5.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					System.exit(0);
				}
			});
		}
		return jMenuItem5;
	}

	private JSeparator getJSeparator() {
		if (jSeparator == null) {
			jSeparator = new JSeparator();
		}
		return jSeparator;
	}

	private JMenuItem getJMenuItem6() {
		if (jMenuItem6 == null) {
			jMenuItem6 = new JMenuItem();
			jMenuItem6.setText("Copy");
			jMenuItem6.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					if (jTextArea.getSelectedText().length()>0)
						jTextArea.copy();
				}
			});
		}
		return jMenuItem6;
	}

	private JMenuItem getJMenuItem7() {
		if (jMenuItem7 == null) {
			jMenuItem7 = new JMenuItem();
			jMenuItem7.setText("Cut");
			jMenuItem7.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					if (jTextArea.getSelectedText().length()>0)
						jTextArea.cut();
				}
			});
		}
		return jMenuItem7;
	}

	private JMenuItem getJMenuItem8() {
		if (jMenuItem8 == null) {
			jMenuItem8 = new JMenuItem();
			jMenuItem8.setText("Paste");
			jMenuItem8.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					jTextArea.paste();
				}
			});
		}
		return jMenuItem8;
	}

	private JMenuItem getJMenuItem9() {
		if (jMenuItem9 == null) {
			jMenuItem9 = new JMenuItem();
			jMenuItem9.setText("Select all");
			jMenuItem9.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					jTextArea.selectAll();
				}
			});
		}
		return jMenuItem9;
	}

	private JMenuItem getJMenuItem12() {
		if (jMenuItem12 == null) {
			jMenuItem12 = new JMenuItem();
			jMenuItem12.setText("About");
		}
		return jMenuItem12;
	}

	private JMenuItem getJMenuItem11() {
		if (jMenuItem11 == null) {
			jMenuItem11 = new JMenuItem();
			jMenuItem11.setText("Contents");
			jMenuItem11.addActionListener(new java.awt.event.ActionListener() {
				public void actionPerformed(java.awt.event.ActionEvent e) {
					try {
						Runtime.getRuntime().exec("hh.exe C:\\WINDOWS\\Help\\atm.chm");
					} catch (IOException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
			});
		}
		return jMenuItem11;
	}

	private JScrollPane getJScrollPane() {
		if (jScrollPane == null) {
			jScrollPane = new JScrollPane();
		}
		return jScrollPane;
	}

	private JTextArea getJTextArea() {
		if (jTextArea == null) {
			jTextArea = new JTextArea();
		}
		return jTextArea;
	}

	private JFileChooser getJFileChooser() 
	{
		if (jFileChooser == null) 
		{
			jFileChooser = new JFileChooser();
		}
		return jFileChooser;
	}

	public static void main(String[] args) {
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				Main thisClass = new Main();
				thisClass.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
				thisClass.jMenuItem2.setEnabled(false);
				thisClass.jMenuItem3.setEnabled(false);
				thisClass.jMenuItem4.setEnabled(false);
				thisClass.jMenu1.setEnabled(false);
				thisClass.jTextArea.setText("");
				thisClass.jTextArea.setVisible(false);
				thisClass.setVisible(true);
			}
		});
	}

	public Main() {
		super();
		initialize();
	}

	private void initialize() {
		this.setSize(636, 285);
		this.setJMenuBar(getJJMenuBar());
		this.setContentPane(getJContentPane());
		this.setTitle("JFrame");
	}

	private JPanel getJContentPane() {
		if (jContentPane == null) {
			jContentPane = new JPanel();
			jContentPane.setLayout(new BorderLayout());
			jContentPane.add(getJScrollPane(), BorderLayout.EAST);
			jContentPane.add(getJTextArea(), BorderLayout.CENTER);
		}
		return jContentPane;
	}

}  //  @jve:decl-index=0:visual-constraint="5,5"
