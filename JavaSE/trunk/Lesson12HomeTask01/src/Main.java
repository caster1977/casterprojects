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
������� JDBC ���������������� ��� ������ � Java

�������. 
� �� �������� �����-������� �������, � ������� ��� ������ ����������� ����� ����� ���� ������� ��������� ��� �������� � ��������. 
�� ������� ������� �������� ��������������� ���������� (�������) �����. 
��� ������� �� ��� ������� �� ������� ��� ������� (����������) �������� �����.
*/

public class Main 
{
	public static void PrintResult(Connection connection, String query, String string) throws SQLException
	{
		// ��������� ������ �� ������ ��
		PreparedStatement preparedStatement = connection.prepareStatement(query);
		preparedStatement.setString(1, string);
		
		if (preparedStatement.execute())
		{
			System.out.println("��������� ������ �� ��������� ���������� �� ������ ���� ������.");
			ResultSet resultSet = preparedStatement.getResultSet();
			ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
			System.out.println("\n���������� ������� �� ����� \""+string+"\":");
			while (resultSet.next())
				System.out.println(resultSet.getString(1));
			System.out.println();				
		}
		else System.out.println("��� ���������� ������� �� ��������� ���������� �� ������ ���� ������ ��������� ������!");
	}

	public static void main(String[] args) 
	{
		// �������� ��������� ����������� �� ����� ��������
		ResourceBundle resourceBundle = ResourceBundle.getBundle("database");
		String host = resourceBundle.getString("host");
		String login = resourceBundle.getString("login");
		String password = resourceBundle.getString("password");
		String db = resourceBundle.getString("db");
		String selectquery = "";
		
		// ��� ����������� ������������ ������� ���� 
		Scanner sc = new Scanner(System.in);
		int choise = 0;
		boolean flag = false;
		while (! flag)
		{
			System.out.print("��� ������ �����-�������� ������� ������� \"1\", ��� ������-����������� ������� \"2\" ��� ������� \"3\" ��� ������: ");
			if (sc.hasNextInt())
			{
				choise = sc.nextInt();
				switch (choise) 
				{
					case 1:
						System.out.println("������������ ������ ����� �����-�������� �������.");
						selectquery = "SELECT russian.word FROM english_to_russian LEFT JOIN english ON english.id = english_to_russian.word_id LEFT JOIN russian ON russian.id = english_to_russian.translation_id WHERE english.word=?;";
						flag = true;					
						break;
					case 2:
						System.out.println("������������ ������ ����� ������-����������� �������.");
						selectquery = "SELECT english.word FROM russian_to_english LEFT JOIN russian ON russian.id = russian_to_english.word_id LEFT JOIN english ON english.id = russian_to_english.translation_id WHERE russian.word=?;";
						flag = true;						
						break;
					case 3:
						System.out.println("���������� ������ ��������� �� ������ ������������.");
						sc.close();
						System.exit(0);
						break;
					default:
						System.out.println("�� ������ ������ ����� �� \"1\" �� \"3\"!");
						break;
				}				
			}
			else 
			{
				System.out.println("������: ������� �������� �� �������������� ��������!");
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
			// ����������� � �������
			cn = DriverManager.getConnection( "jdbc:mysql://"+host+"/", login, password);
			System.out.println("��������� ���������� � �������� ��� ������.");

			statement = cn.createStatement();
			
			// ������������ ������� ��������
			if (statement.executeUpdate("SET NAMES cp1251;")>=0)
				System.out.println("�������� ����� ������� �������� \"cp1251\" ��� ������ � ����� ������.");

			// ����������� ������������ ��
			if (statement.executeUpdate("DROP DATABASE IF EXISTS `"+db+"`;")>=0)
				System.out.println("��������� �������� ����� ��������� ���� ������ \""+db+"\".");

			// �������� ��
			statement = cn.createStatement();
			if (statement.executeUpdate("CREATE DATABASE `"+db+"` /*!40100 DEFAULT CHARACTER SET cp1251 */;")>=0)
				System.out.println("��������� �������� ���� ������ \""+db+"\".");
							
			// ����� �� ��� ������
			cn.setCatalog(db);
			System.out.println("�������� ����� ���� ������ \""+cn.getCatalog()+"\".");

			statement = cn.createStatement();

			// �������� ������ ��
			if (statement.executeUpdate("CREATE TABLE `english` (`id` int(11) unsigned NOT NULL auto_increment, `word` varchar(255) NOT NULL default '', PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=cp1251;")>=0)
				System.out.println("��������� �������� ������� ���� ������ ��� ���������� ����.");
			if (statement.executeUpdate("CREATE TABLE `russian` (`id` int(11) unsigned NOT NULL auto_increment, `word` varchar(255) NOT NULL default '', PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=cp1251;")>=0)
				System.out.println("��������� �������� ������� ���� ������ ��� ������� ����.");
			if (statement.executeUpdate("CREATE TABLE `english_to_russian` (`id` int(11) unsigned NOT NULL auto_increment, `word_id` int(11) unsigned default NULL, `translation_id` int(11) unsigned default NULL, PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=cp1251;")>=0)
				System.out.println("��������� �������� ������� ���� ������ ��� ������ ���������� ���� � ��������.");
			if (statement.executeUpdate("CREATE TABLE `russian_to_english` (`id` int(11) unsigned NOT NULL auto_increment, `word_id` int(11) unsigned default NULL, `translation_id` int(11) unsigned default NULL, PRIMARY KEY  (`id`)) ENGINE=MyISAM DEFAULT CHARSET=cp1251;")>=0)
				System.out.println("��������� �������� ������� ���� ������ ��� ������ ������� ���� � �����������.");
			
			// ���������� ������ ��
			if (statement.executeUpdate("INSERT INTO `english` VALUES (1,'table');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ���������� ����.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (2,'sun');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ���������� ����.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (3,'tree');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ���������� ����.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (4,'window');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ���������� ����.");
			if (statement.executeUpdate("INSERT INTO `english` VALUES (5,'wood');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ���������� ����.");

			if (statement.executeUpdate("INSERT INTO `russian` VALUES (1,'�������');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������� ����.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (2,'����');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������� ����.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (3,'������');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������� ����.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (4,'����');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������� ����.");
			if (statement.executeUpdate("INSERT INTO `russian` VALUES (5,'������');")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������� ����.");
			
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (1,1,1);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ���������� ���� � ��������.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (2,1,2);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ���������� ���� � ��������.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (3,2,3);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ���������� ���� � ��������.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (4,3,5);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ���������� ���� � ��������.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (5,4,4);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ���������� ���� � ��������.");
			if (statement.executeUpdate("INSERT INTO `english_to_russian` VALUES (6,5,5);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ���������� ���� � ��������.");
			
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (1,1,1);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ������� ���� � �����������.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (2,2,1);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ������� ���� � �����������.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (3,3,2);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ������� ���� � �����������.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (4,4,4);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ������� ���� � �����������.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (5,5,3);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ������� ���� � �����������.");
			if (statement.executeUpdate("INSERT INTO `russian_to_english` VALUES (6,5,5);")==1)
				System.out.println("��������� ������� ������ � ������� ���� ������ ��� ������ ������� ���� � �����������.");
			
			// ��������� ������ �� ������ ��
			String word = "";
			while (!(word.compareTo("q")==0))
			{
				System.out.print("������� ����� ��� ������ �� ������� ���� �������� \"q\" ��� ������: ");
				if (sc.hasNext())
				{
					word = sc.next();
					if (word.compareTo("q")==0)
					{
						System.out.println("�������� ����� �� ������ ��������.");
					}
					else PrintResult(cn, selectquery, word);
				}
			}		
			
			// ���������� �� �������		
			cn.close();
			System.out.println("��������� ���������� �� ������� ��� ������.");
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		}		
	
		sc.close();		
	}
}
