
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;

public class JDBC_Demo 
{
	public static void main(String[] args) 
	{
		//System.out.println(ClassLoader.getSystemResource(""));
		ResourceBundle resourceBundle = ResourceBundle.getBundle("database");
		String host = resourceBundle.getString("host");
		String login = resourceBundle.getString("login");
		String password = resourceBundle.getString("password");
		String db = resourceBundle.getString("db");
		
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
			// cn = DriverManager.getConnection( "jdbc:mysql://"+host+"/"+db, login, password);
			cn = DriverManager.getConnection( "jdbc:mysql://"+host+"/", login, password);
			System.out.println("Connection successful.");
			cn.setCatalog(db);
			System.out.println("Database \""+cn.getCatalog()+"\" selected successful.");
			
			statement = cn.createStatement();
			
			if (statement.execute("SELECT * FROM emp ORDER BY EMPNAME;")==true)
			{
				System.out.println("Query executed successfully!");
				ResultSet resultSet = statement.getResultSet();
				ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
				System.out.println("\nResults:");
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
			else System.out.println("Can't execute query!");
			
			preparedStatement = cn.prepareStatement("SELECT * FROM emp WHERE EMPNAME=?;");
			preparedStatement.setString(1, "WARD");
			
			if (preparedStatement.execute())
			{
				System.out.println("Query executed successfully!");
				ResultSet resultSet = preparedStatement.getResultSet();
				ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
				System.out.println("\nResults:");
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
			else System.out.println("Can't execute query!");

			cn.close();
			System.out.println("Connection closed.");
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		}		
	}
}
