import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;

/*
Урок 8. Задание 2. Вариант 4.
При выполнении следующих заданий для вывода результатов создавать новую директорию и файл средствами класса File.
Прочитать текст Java-программы и в каждом слове длиннее двух символов все строчные символы заменить прописными.
*/

public class Main 
{
	public static String CurrentDir()
	{
		String path=System.getProperty("java.class.path"); 
		String FileSeparator=(String)System.getProperty("file.separator");
		return path.substring(0,path.lastIndexOf(FileSeparator)+1); 
	}

	public static void main(String[] args) 
	{
		try 
		{
			FileReader fileReader = null;
			BufferedReader bufferedReader = null;

			String curDir = CurrentDir();

			fileReader = new FileReader(curDir+File.separator+"src"+File.separator+"Main.java");
			bufferedReader = new BufferedReader(fileReader);

			boolean eof = false;
			ArrayList<String> strings = new ArrayList<String>(); 
			while (!eof) 
			{
				String line = bufferedReader.readLine();
				if (line == null)
					eof = true;
				else
				{
					String tokens = " \n\t,.:;!?“”+-\"(){}=[]*/";
					StringTokenizer stringTokenizer = new StringTokenizer(line, tokens);
					
					while (stringTokenizer.hasMoreTokens()) 
					{
						String s = stringTokenizer.nextToken().trim();
						if (s.length()>2)
						{
							String string = s.substring(0, 2) + s.substring(2, s.length()).toUpperCase();
							line = line.replaceFirst(s, string);
						}
					}
					strings.add(line);
				}
			}
			bufferedReader.close();
			fileReader.close();
			
			FileWriter fileWriter = null;
			BufferedWriter bufferedWriter = null;
			
			File td = new File(curDir+File.separator+"src"+File.separator+"newdir");
			if (!(td.exists() && td.isDirectory()))
				td.mkdir();
			
			fileWriter = new FileWriter(curDir+File.separator+"src"+File.separator+"newdir"+File.separator+"MaIN.jaVA");
			bufferedWriter = new BufferedWriter(fileWriter);
			
			for (Iterator<String> iterator = strings.iterator(); iterator.hasNext();) 
			{
				String string = (String) iterator.next();
				System.out.println(string);
				bufferedWriter.write(string);
				bufferedWriter.newLine();
			}
			bufferedWriter.flush();
			bufferedWriter.close();
			fileWriter.close();			
		} 
		catch (IOException e) 
		{
			System.out.println(e.toString());
		}
	}
}
