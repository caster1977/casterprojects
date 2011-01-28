/*
Урок 8. Задание 3. Вариант 4.
Из текстового файла ввести последовательность строк. 
Выделить отдельные слова, разделяемые пробелами. 
Написать метод поиска слова по образцу-шаблону. 
Вывести найденное слово в другой файл.
*/

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.StringTokenizer;

public class Main 
{
	public static void FindInTextAndSaveToFile(String searchfor, ArrayList<String> content)
	{
		File td = new File(CurrentDir()+File.separator+"src"+File.separator+"SearchResults");
		if (!(td.exists() && td.isDirectory()))
			td.mkdir();

		FileWriter fileWriter = null;
		BufferedWriter bufferedWriter = null;
		
		try 
		{
			fileWriter = new FileWriter(CurrentDir()+File.separator+"src"+File.separator+"SearchResults"+File.separator+"results_for_"+searchfor+".txt");
			bufferedWriter = new BufferedWriter(fileWriter);

			for (int i = 0; i < content.size(); i++) 
			{
				String string2 = content.get(i);

				String tokens = " \n\t,.:;!?“”+-\"(){}=[]*";
				StringTokenizer stringTokenizer = new StringTokenizer(string2, tokens);
				
				while (stringTokenizer.hasMoreTokens()) 
				{
					String current = stringTokenizer.nextToken().trim();
					if (current.startsWith(searchfor))
					{
						try 
						{					
							bufferedWriter.write(current);
							bufferedWriter.newLine();
							System.out.println(current.toString());
						} 
						catch (IOException e) 
						{
							e.printStackTrace();
						}
					}				
				}
			}

			try 
			{
				bufferedWriter.flush();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			try 
			{
				bufferedWriter.close();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}
			try 
			{
				System.out.println("Результаты поиска записаны в файл \""+CurrentDir()+File.separator+"src"+File.separator+"SearchResults"+File.separator+"results_for_"+searchfor+".txt"+"\".");
				fileWriter.close();
			} 
			catch (IOException e) 
			{
				e.printStackTrace();
			}			
		} 
		catch (IOException e1) 
		{
			e1.printStackTrace();
		}
	}
	
	public static void main(String[] args) 
	{
		ArrayList<String> strings = new ArrayList<String>(); 
		try 
		{
			FileReader dataFile = null;
			BufferedReader buff = null;

			dataFile = new FileReader(CurrentDir()+File.separator+"src"+File.separator+"Main.java");
			buff = new BufferedReader(dataFile);
			boolean eof = false;
			while (!eof) 
			{
				String line = buff.readLine();
				if (line == null)
					eof = true;
				else
				{
					strings.add(line);
				}
			}
			dataFile.close();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		
		Scanner sc = new Scanner(System.in);
		boolean flag = false;
		String string = ""; 

		while (! flag)
		{
			System.out.print("Введите слово для поиска в файле или нажмите Ctrl+Z для выхода: ");
			if (sc.hasNext())
			{
				flag = true;
				string = sc.next().trim();
			}
		}
		
		sc.close();
		
		if (string!="")
			FindInTextAndSaveToFile(string, strings);
	}

	public static String CurrentDir()
	{
		String path=System.getProperty("java.class.path"); 
		String FileSeparator=(String)System.getProperty("file.separator"); 
		return path.substring(0, path.lastIndexOf(FileSeparator)+1); 
	}	
}
