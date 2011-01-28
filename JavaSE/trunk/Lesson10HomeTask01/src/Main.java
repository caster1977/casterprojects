/* 
 * ������� 10. ������� 4. 
 * ������� ������ �� ��������� �������� � ��� ������������.
 */

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Scanner;

public class Main 
{
	static long id = 0;

	public static ArrayList<Element> AddFilesToList(long _parent_id, String _name, ArrayList<Element> _list)
	{
		File file = new File(_name);
		if (!(file.exists()))
		{
			System.out.println("����, ��������� ���� �� ����������!");
		}
		else
		{
			if (file.isFile())
			{
				// ���������� ����� � ������
				System.out.println("���������� � ������ ����� \""+file.getAbsolutePath()+"\".");
				try 
				{
					_list.add(new Element(id, _name, false, _parent_id));
				} 
				catch (MyException e) 
				{
					e.printStackTrace();
				}
				id++;
			}
			else 
				if (file.isDirectory())
				{
					// ���������� �������� � ������
					System.out.println("���������� � ������ �������� \""+file.getAbsolutePath()+"\".");
					try 
					{
						_list.add(new Element(id, _name, true, _parent_id));
					} 
					catch (MyException e) 
					{
						e.printStackTrace();
					}
					long parent = id;
					id++;

					// ��������� ����������� �������� � ��� ���������
					String[] fileList = file.list(); 
					
					if (fileList.length>0)
					{
						for (String string : fileList) 
						{
							if ((string!=".")&&(string!="..")&&(string.trim()!=""))
								_list = AddFilesToList(parent, _name+File.separator+string, _list);
						}
					}
				}
		}		
		return _list;
	}
	
	public static void main(String[] args) 
	{
		ArrayList<Element> elements = new ArrayList<Element>();
		
		Scanner sc = new Scanner(System.in);
		boolean flag = false;
		String catalog = ""; 

		flag = false;
		while (! flag)
		{
			System.out.print("������� ����, ������ �������� ����� ��������� ��� ������� Ctrl+Z ��� ������: ");
			if (sc.hasNext())
			{
				flag = true;
				catalog = sc.next();
			}
		}
		
		sc.close();
		
		if (!(catalog.endsWith(File.separator)))
		{
			catalog = catalog + File.separator;
		}
		
		elements = AddFilesToList(-1, catalog, elements);
		
		for (Iterator<Element> iterator = elements.iterator(); iterator.hasNext();) 
		{
			Element element = (Element) iterator.next();
			System.out.println(element.toString());			
		}
	}
}
