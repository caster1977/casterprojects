package Lesson03Task04Package;

public class Books 
{
	private Book[] _books;
	{
		_books = new Book[10];
		String[] _authors0 = {"������", "������"};
		_books[0] = new Book(1, "������", _authors0, "������� �����", 1980, 50, 2.0, TCover.������);
		String[] _authors1 = {"������"};
		_books[1] = new Book(2, "����������", _authors1, "������� �����", 1985, 50, 3.50, TCover.������);
		String[] _authors2 = {"������"};
		_books[2] = new Book(3, "������", _authors2, "������� �����", 1987, 50, 7.8, TCover.������);
		String[] _authors3 = {"�������"};
		_books[3] = new Book(4, "���������", _authors3, "������������", 1988, 50, 9.0, TCover.������);
		String[] _authors4 = {"���"};
		_books[4] = new Book(5, "������-5", _authors4, "������� �����", 1989, 50, 54.0, TCover.������);
		String[] _authors5 = {"���", "������"};
		_books[5] = new Book(6, "������-2", _authors5, "������� �����", 1981, 50, 235.66, TCover.������);
		String[] _authors6 = {"����������"};
		_books[6] = new Book(7, "������-4", _authors6, "������� �����", 1983, 50, 80.99, TCover.������);
		String[] _authors7 = {"��������"};
		_books[7] = new Book(8, "������� ����", _authors7, "������� �����", 1956, 50, 23.40, TCover.������);
		String[] _authors8 = {"�������"};
		_books[8] = new Book(9, "���������������� �� Java", _authors8, "����������", 2010, 50, 20.50, TCover.������);
		String[] _authors9 = {"������"};
		_books[9] = new Book(10, "������-6", _authors9, "������� �����", 1988, 50, 860.0, TCover.������);
	}
	public void ShowBooksByAuthor(String author)
	{
		System.out.printf("��������� ����� ������ \"%s\":\n", author);
		for (int i=0;i<_books.length;i++)
		{
			for (int j=0;j<_books[i].get_authors().length;j++)
				if(_books[i].get_authors()[j]==author)				
					System.out.println(_books[i].toString());
		}
	}
	
	public void ShowBooksByPublishingHouse(String publishing_house)
	{
		String s = "";
		System.out.printf("��������� ����� ������������ \"%s\":\n", s);
		for (int i=0;i<_books.length;i++)
		{
			if(_books[i].get_publishing_house()==publishing_house)				
				System.out.println(_books[i].toString());
		}
	}
	
	public void ShowBooksRealeasedAfterYear(int year)
	{
		System.out.printf("�����, �������� ����� %d ����:\n", year);
		for (int i=0;i<_books.length;i++)
		{
			if(_books[i].get_year()>year)				
				System.out.println(_books[i].toString());
		}
	}
	

}
