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
� ������ �� ������� ���������� ��������� ��������� ��������:
� ����������� ���������� � ����� ������ ������� � ��������� �����, ����� �������� ���������� ����������.
� ������� ��. �������� ������� � ����� �� ������������� ����.
� ������� ����� ��� ���������� �������� �� ���������� ���������� �� �� � �������������� ��������������� ��������.
� ������� ����� �� ���������� ����������.
� ���������� ���������� ������� ������� � �������.

�������. 
� �� �������� �����-������� �������, � ������� ��� ������ ����������� ����� ����� ���� ������� ��������� ��� �������� � ��������. 
�� ������� ������� �������� ��������������� ���������� (�������) �����. 
��� ������� �� ��� ������� �� ������� ��� ������� (����������) �������� �����.
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
		// �������� ��������� ����������� �� ����� ��������
		ResourceBundle resourceBundle = ResourceBundle.getBundle("database");
		String host = resourceBundle.getString("host");
		String login = resourceBundle.getString("login");
		String password = resourceBundle.getString("password");
		String db = resourceBundle.getString("db");
		
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
						flag = true;					
						break;
					case 2:
						System.out.println("������������ ������ ����� ������-����������� �������.");
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
			cn = DriverManager.getConnection( "jdbc:mysql://"+host+"/", login, password);
			System.out.println("���������� � �������� ����������.");
			cn.setCatalog(db);
			System.out.println("���� ������ \""+cn.getCatalog()+"\" ������� �������.");
			
			statement = cn.createStatement();
			
			if (statement.execute("SELECT * FROM emp ORDER BY EMPNAME;")==true)
			{
				System.out.println("������ �������� �������.");
				ResultSet resultSet = statement.getResultSet();
				ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
				System.out.println("\n���������� �������:");
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
			else System.out.println("������ ���������� �������!");
			
			preparedStatement = cn.prepareStatement("SELECT * FROM emp WHERE EMPNAME=?;");
			preparedStatement.setString(1, "WARD");
			
			if (preparedStatement.execute())
			{
				System.out.println("������ �������� �������!");
				ResultSet resultSet = preparedStatement.getResultSet();
				ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
				System.out.println("\n���������� �������:");
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
			else System.out.println("������ ���������� �������!");

			cn.close();
			System.out.println("���������� � �������� ���������.");
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		}		
	
		sc.close();		
	}
}
