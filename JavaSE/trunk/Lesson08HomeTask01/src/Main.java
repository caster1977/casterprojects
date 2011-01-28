import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.ResourceBundle;
import java.util.StringTokenizer;

/*
���� 8. ������� 1. ������� 4.
� ��������� �������� ��������� ������ ������������������ ����� �� ���������� ������ � ��������� ��������� ��������. 
��� ���� ����� ��������������� ��� ��������:
- ������ ������ ������� �� ������ �����;
- ������ ������ ������� �� ���������� ����.
����� �������� � ��������� ������, � ����� ���������� ���� � ��� ����� ���� ������� ��� ��������� ��������� ������ ��� ��������� � �����.

����� � ������� ����� ������, ��� ������� ��������� ����� ������ ����� ��������� � ������ ������ ���������� �����.
*/

public class Main 
{
	public static void main(String[] args) 
	{
		String input_file = "";
		String output_file = "";
		// ���� ����� �������� � ��������� ������ ���� �������� ��� ��������� ��������� ������ 
		if (args.length==2)
		{
			input_file = args[0];
			output_file = args[1];
		}
		else // ����� �������� ������� �� �� ����� task.properties
		{
			ResourceBundle resourceBundle = ResourceBundle.getBundle("task");
			input_file = resourceBundle.getString("input_file");
			output_file = resourceBundle.getString("output_file");		
		}
		
		System.out.println("��� ��������� �����: "+input_file);
		System.out.println("��� ��������������� �����: "+output_file);
		
		File file_input_file = new File(input_file);
		
		if ((file_input_file.exists())&&(file_input_file.isFile()))
		{
			FileReader fileReader = null;
			BufferedReader bufferedReader = null;

			try 
			{
				fileReader = new FileReader(input_file);
				bufferedReader = new BufferedReader(fileReader);

				boolean eof = false;
				ArrayList<String> strings = new ArrayList<String>(); 
				while (!eof) 
				{
					String line = "";
					String previousWord = "";
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
						String tokens = " \n\t,.:;!?��+-\"(){}=[]*/";
						StringTokenizer stringTokenizer = new StringTokenizer(line, tokens);
						
						while (stringTokenizer.hasMoreTokens()) 
						{
							String string = stringTokenizer.nextToken().trim();
							if (previousWord.length()>0)
							{
								Character ch = previousWord.charAt(previousWord.length()-1);
								if (string.startsWith(ch.toString()))
								{
									strings.add(previousWord+" "+string);
								}
							}
							previousWord = string;
						}
					}
				}
				System.out.println("�������� ���� ������� ��������.");
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

				if (!(strings.isEmpty()))
				{
					FileWriter fileWriter = null;
					BufferedWriter bufferedWriter = null;
			
					try 
					{
						fileWriter = new FileWriter(output_file);
						bufferedWriter = new BufferedWriter(fileWriter);
						
						for (Iterator<String> iterator = strings.iterator(); iterator.hasNext();) 
						{
							String string = (String) iterator.next();
							
							bufferedWriter.write(string);
							bufferedWriter.newLine();
						}
						bufferedWriter.flush();
						System.out.println("�������������� ���� ������� �������.");
						bufferedWriter.close();
						fileWriter.close();
					} 
					catch (IOException e) 
					{
						e.printStackTrace();
					}					
				}				
			} 
			catch (FileNotFoundException e) 
			{
				e.printStackTrace();
			}
		}
		else
		{
			System.out.println("�������� ���� �� ������!");
		}
	}
}
