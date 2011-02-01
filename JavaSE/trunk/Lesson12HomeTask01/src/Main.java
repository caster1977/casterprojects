import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import java.util.Scanner;

/* 
Задания JDBC Программирование баз данных в Java
В каждом из заданий необходимо выполнить следующие действия:
• Организацию соединения с базой данных вынести в отдельный класс, метод которого возвращает соединение.
• Создать БД. Привести таблицы к одной из нормированных форм.
• Создать класс для выполнения запросов на извлечение информации из БД с использованием компилированных запросов.
• Создать класс на добавление информации.
• Результаты выполнения запроса вывести в консоль.

Словарь. 
В БД хранится англо-русский словарь, в котором для одного английского слова может быть указано несколько его значений и наоборот. 
Со стороны клиента вводятся последовательно английские (русские) слова. 
Для каждого из них вывести на консоль все русские (английские) значения слова.
 */


//CREATE DATABASE `dictionary` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*
SET NAMES utf8;

CREATE TABLE `english` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `word` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `russian` (
		  `id` int(11) unsigned NOT NULL auto_increment,
		  `word` varchar(255) NOT NULL default '',
		  PRIMARY KEY  (`id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `english_to_russian` (
		  `id` int(11) unsigned NOT NULL default '0',
		  `word_id` int(11) unsigned default NULL,
		  `translation_id` int(11) unsigned default NULL,
		  PRIMARY KEY  (`id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `russian_to_english` (
		  `id` int(11) unsigned NOT NULL default '0',
		  `word_id` int(11) unsigned default NULL,
		  `translation_id` int(11) unsigned default NULL,
		  PRIMARY KEY  (`id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8;
*/

public class Main 
{
	public static void main(String[] args) 
	{
		// получаем настройки подключения из файла настроек
		ResourceBundle resourceBundle = ResourceBundle.getBundle("database");
		String host = resourceBundle.getString("host");
		String login = resourceBundle.getString("login");
		String password = resourceBundle.getString("password");
		String db = resourceBundle.getString("db");
		
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
						flag = true;					
						break;
					case 2:
						System.out.println("Пользователь выбрал режим русско-английского словаря.");
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
		PreparedStatement preparedStatement = null;
		
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
			cn = DriverManager.getConnection( "jdbc:mysql://"+host+"/", login, password);
			System.out.println("Соединение с сервером утановлено.");
			cn.setCatalog(db);
			System.out.println("База данных \""+cn.getCatalog()+"\" выбрана успешно.");
			
			statement = cn.createStatement();
			
			if (statement.execute("SELECT * FROM emp ORDER BY EMPNAME;")==true)
			{
				System.out.println("Запрос выполнен успешно.");
				ResultSet resultSet = statement.getResultSet();
				ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
				System.out.println("\nРезультаты запроса:");
				while (resultSet.next())
				{
					for (int i=1;i<=resultSetMetaData.getColumnCount();i++)
					{
						System.out.print(resultSetMetaData.getColumnLabel(i)+": "+resultSet.getString(i)+"\t");
					}
					System.out.println();
				}
				System.out.println();				
			}
			else System.out.println("Ошибка выполнения запроса!");
			
			preparedStatement = cn.prepareStatement("SELECT * FROM emp WHERE EMPNAME=?;");
			preparedStatement.setString(1, "WARD");
			
			if (preparedStatement.execute())
			{
				System.out.println("Запрос выполнен успешно!");
				ResultSet resultSet = preparedStatement.getResultSet();
				ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
				System.out.println("\nРезультаты запроса:");
				while (resultSet.next())
				{
					for (int i=1;i<=resultSetMetaData.getColumnCount();i++)
					{
						System.out.print(resultSetMetaData.getColumnLabel(i)+": "+resultSet.getString(i)+"\t");
					}
					System.out.println();
				}
				System.out.println();				
			}
			else System.out.println("Ошибка выполнения запроса!");

			cn.close();
			System.out.println("Соединение с сервером разорвано.");
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		}		
	
		sc.close();		
	}
}
