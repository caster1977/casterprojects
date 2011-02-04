import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import java.util.Scanner;

/* 
Задания JDBC Программирование баз данных в Java

Словарь. 
В БД хранится англо-русский словарь, в котором для одного английского слова может быть указано несколько его значений и наоборот. 
Со стороны клиента вводятся последовательно английские (русские) слова. 
Для каждого из них вывести на консоль все русские (английские) значения слова.
*/

public class Main 
{
	public static void PrintResult(Connection connection, String query, String string) throws SQLException
	{
		// получение данных из таблиц БД
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setString(1, string);
		
		if (preparedStatement.execute())
		{
			System.out.println("Выполнено запрос на получение информации из таблиц базы данных.");
			ResultSet resultSet = preparedStatement.getResultSet();
			System.out.println("\nРезультаты запроса по слову \""+string+"\":");
			while (resultSet.next())
				System.out.println(resultSet.getString(1));
			System.out.println();				
		}
		else System.out.println("При выполнении запроса на получение информации из таблиц базы данных произошла ошибка!");
	}

	public static void main(String[] args) 
	{
		// получаем настройки подключения из файла настроек
		ResourceBundle resourceBundle = ResourceBundle.getBundle("database");
		String host = resourceBundle.getString("host");
		String login = resourceBundle.getString("login");
		String password = resourceBundle.getString("password");
		String db = resourceBundle.getString("db");
		String selectquery = "";
		
		// даём возможность пользователю выюрать язык 
		Scanner sc = new Scanner(System.in);
		int choise = 0;
		boolean flag = false;
		while (! flag)
		{
			System.out.print("Для выбора англо-русского словаря введите \"1\", для русско-английского введите \"2\" или нажмите \"3\" для выхода: ");
			if (sc.hasNextInt())
			{
				choise = sc.nextInt();
				switch (choise) 
				{
					case 1:
						System.out.println("Пользователь выбрал режим англо-русского словаря.");
						selectquery = "SELECT russian.word FROM english_to_russian LEFT JOIN english ON english.id = english_to_russian.word_id LEFT JOIN russian ON russian.id = english_to_russian.translation_id WHERE english.word=?;";
						flag = true;					
						break;
					case 2:
						System.out.println("Пользователь выбрал режим русско-английского словаря.");
						selectquery = "SELECT english.word FROM russian_to_english LEFT JOIN russian ON russian.id = russian_to_english.word_id LEFT JOIN english ON english.id = russian_to_english.translation_id WHERE russian.word=?;";
						flag = true;						
						break;
					case 3:
						System.out.println("Завершение работы программы по выбору пользователя.");
						sc.close();
						System.exit(0);
						break;
					default:
						System.out.println("Вы должны ввести число от \"1\" до \"3\"!");
						break;
				}				
			}
			else 
			{
				System.out.println("Ошибка: введено отличное от целочисленного значение!");
				sc.next();
			}
		}
		Connection cn = null;
		Statement statement = null;
		
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
		} 
		catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
		}

		try 
		{
			// подключение к серверу
			cn = DriverManager.getConnection( "jdbc:mysql://"+host+"/", login, password);
			System.out.println("Выполнено соединение с сервером баз данных.");

			statement = cn.createStatement();
			
			// переключение кодовой страницы
			if (statement.executeUpdate("SET NAMES utf8;")>=0)
				System.out.println("Выполнен выбор кодовой страницы \"utf8\" для работы с базой данных.");

			// уничтожение существующей БД
			if (statement.executeUpdate("DROP DATABASE IF EXISTS `"+db+"`;")>=0)
				System.out.println("Выполнено удаление ранее имеющейся базы данных \""+db+"\".");

			// создание БД
			statement = cn.createStatement();
			if (statement.executeUpdate("CREATE DATABASE `"+db+"` /*!40100 DEFAULT CHARACTER SET utf8 */;")>=0)
				System.out.println("Выполнено создание базы данных \""+db+"\".");
							
			// выбор БД для работы
			cn.setCatalog(db);
			System.out.println("Выполнен выбор Базы данных \""+cn.getCatalog()+"\".");

			statement = cn.createStatement();

			// создание таблиц БД
			if (statement.executeUpdate("CREATE TABLE `english` (`id` int(11) unsigned NOT NULL auto_increment, `word` varchar(255) NOT NULL default '', PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;")>=0)
				System.out.println("Выполнено создание таблицы базы данных для английских слов.");
			if (statement.executeUpdate("CREATE TABLE `russian` (`id` int(11) unsigned NOT NULL auto_increment, `word` varchar(255) NOT NULL default '', PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;")>=0)
				System.out.println("Выполнено создание таблицы базы данных для русских слов.");
			if (statement.executeUpdate("CREATE TABLE `english_to_russian` (`id` int(11) unsigned NOT NULL auto_increment, `word_id` int(11) unsigned default NULL, `translation_id` int(11) unsigned default NULL, PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;")>=0)
				System.out.println("Выполнено создание таблицы базы данных для связки английских слов с русскими.");
			if (statement.executeUpdate("CREATE TABLE `russian_to_english` (`id` int(11) unsigned NOT NULL auto_increment, `word_id` int(11) unsigned default NULL, `translation_id` int(11) unsigned default NULL, PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;")>=0)
				System.out.println("Выполнено создание таблицы базы данных для связки русских слов с английскими.");
			
			// заполнение таблиц БД
			if (statement.executeUpdate("INSERT INTO `english` VALUES (1,'table');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для английских слов.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (2,'sun');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для английских слов.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (3,'tree');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для английских слов.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (4,'window');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для английских слов.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (5,'wood');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для английских слов.");

			if (statement.executeUpdate("INSERT INTO `russian` VALUES (1,'tablica');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для русских слов.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (2,'stol');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для русских слов.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (3,'solnce');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для русских слов.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (4,'okno');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для русских слов.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (5,'derevo');")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для русских слов.");
			
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (1,1,1);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки английских слов с русскими.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (2,1,2);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки английских слов с русскими.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (3,2,3);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки английских слов с русскими.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (4,3,5);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки английских слов с русскими.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (5,4,4);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки английских слов с русскими.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (6,5,5);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки английских слов с русскими.");
			
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (1,1,1);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки русских слов с английскими.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (2,2,1);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки русских слов с английскими.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (3,3,2);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки русских слов с английскими.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (4,4,4);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки русских слов с английскими.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (5,5,3);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки русских слов с английскими.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (6,5,5);")==1)
				System.out.println("Выполнена вставка записи в таблицу базы данных для связки русских слов с английскими.");
			
			// получение данных из таблиц БД
			String word = "";
			while (!(word.compareTo("q")==0))
			{
				System.out.print("Введите слово для поиска по словарю либо наберите \"q\" для выхода: ");
				if (sc.hasNext())
				{
					word = sc.next();
					if (word.compareTo("q")==0)
					{
						System.out.println("Выполнен выход из режима перевода.");
					}
					else PrintResult(cn, selectquery, word);
				}
			}		
			
			// отключение от сервера		
			cn.close();
			System.out.println("Выполнено отключение от сервера баз данных.");
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		}		
	
		sc.close();		
	}
}
