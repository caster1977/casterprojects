package Lesson03Task04Package;

public class Books 
{
	private Book[] _books;
	{
		_books = new Book[10];
		String[] _authors0 = {"Иванов", "Петров"};
		_books[0] = new Book(1, "Азбука", _authors0, "Научная книга", 1980, 50, 2.0, TCover.твёрдая);
		String[] _authors1 = {"Иванов"};
		_books[1] = new Book(2, "Грамматика", _authors1, "Научная книга", 1985, 50, 3.50, TCover.твёрдая);
		String[] _authors2 = {"Петров"};
		_books[2] = new Book(3, "Азбука", _authors2, "Научная книга", 1987, 50, 7.8, TCover.твёрдая);
		String[] _authors3 = {"Сидоров"};
		_books[3] = new Book(4, "Вышивание", _authors3, "Рукодельница", 1988, 50, 9.0, TCover.твёрдая);
		String[] _authors4 = {"Жук"};
		_books[4] = new Book(5, "Азбука-5", _authors4, "Научная книга", 1989, 50, 54.0, TCover.твёрдая);
		String[] _authors5 = {"Жук", "Петров"};
		_books[5] = new Book(6, "Азбука-2", _authors5, "Научная книга", 1981, 50, 235.66, TCover.твёрдая);
		String[] _authors6 = {"Петровский"};
		_books[6] = new Book(7, "Азбука-4", _authors6, "Научная книга", 1983, 50, 80.99, TCover.твёрдая);
		String[] _authors7 = {"Михайлов"};
		_books[7] = new Book(8, "Русский язык", _authors7, "Научная книга", 1956, 50, 23.40, TCover.твёрдая);
		String[] _authors8 = {"Петрова"};
		_books[8] = new Book(9, "Программирование на Java", _authors8, "Белпросвет", 2010, 50, 20.50, TCover.твёрдая);
		String[] _authors9 = {"Петров"};
		_books[9] = new Book(10, "Азбука-6", _authors9, "Научная книга", 1988, 50, 860.0, TCover.твёрдая);
	}
	public void ShowBooksByAuthor(String author)
	{
		System.out.printf("Имеющиеся книги автора \"%s\":\n", author);
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
		System.out.printf("Имеющиеся книги издательства \"%s\":\n", s);
		for (int i=0;i<_books.length;i++)
		{
			if(_books[i].get_publishing_house()==publishing_house)				
				System.out.println(_books[i].toString());
		}
	}
	
	public void ShowBooksRealeasedAfterYear(int year)
	{
		System.out.printf("Книги, вышедшие после %d года:\n", year);
		for (int i=0;i<_books.length;i++)
		{
			if(_books[i].get_year()>year)				
				System.out.println(_books[i].toString());
		}
	}
	

}
