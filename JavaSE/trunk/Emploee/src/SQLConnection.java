import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.ResourceBundle;

import javax.swing.JOptionPane;


public class SQLConnection {
	private Connection connection;
	private Statement statement;
	private ResultSet resultSet;
	private ResultSetMetaData resultSetMetaData;
	private String driver;
	private String url;
	private String user;
	private String password;
	private ResourceBundle resourceBundle;
	private String source;
	
	
	public SQLConnection(String sql) throws ClassNotFoundException, SQLException, IOException {
		super();
		initConnection(sql);
	}

	public void initConnection(String sql) throws ClassNotFoundException, SQLException, IOException{
		getResourceBundle();
		Class.forName(driver);	
		getConnection();
		getStatement();
		getResultSet(sql);
		getResultSetMetaData();
	}
	
	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = "database";
	}

	public ResourceBundle getResourceBundle() throws IOException {
		resourceBundle = ResourceBundle.getBundle("database");
		driver = resourceBundle.getString("driver");
		url = resourceBundle.getString("url");
		user = resourceBundle.getString("user");
		password = resourceBundle.getString("password");
		return resourceBundle;
	}
	public String getDriver() {
		return driver;
	}
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Connection getConnection() throws SQLException {
		connection = DriverManager.getConnection(url, user, password);
		return connection;
	}
	public Statement getStatement() throws SQLException {
		statement = connection.createStatement();
		return statement;
	}
	public ResultSet getResultSet(String sql) throws SQLException {
		resultSet = statement.executeQuery(sql);
		return resultSet;
	}
	public ResultSetMetaData getResultSetMetaData() throws SQLException {
		resultSetMetaData = resultSet.getMetaData();
		return resultSetMetaData;
	}
	
	public Object[] getColumnName() throws SQLException{
		Object[] array = new Object[resultSetMetaData.getColumnCount()];
		for (int i = 0; i < array.length; i++) {
			array[i]=resultSetMetaData.getColumnName(i+1);
		}
		return array;
	}
	public Object[][] getRowData() throws SQLException{
		List<List<Object>> list = new ArrayList<List<Object>>();
		while(resultSet.next()){
			List<Object> row = new ArrayList<Object>();
			for (int j = 1; j <= getColumnCount(); j++) {
				row.add(resultSet.getObject(j));
			}
			list.add(row);
		}
		
		Object[][] dataTable =new Object[list.size()] [getColumnCount()];
		ListIterator<List<Object>> listIterator = list.listIterator();
		while (listIterator.hasNext()){
			    List<?> getRow = (List<?>)listIterator.next();
			    ListIterator<?> rowIterator = getRow.listIterator();
			    while (rowIterator.hasNext()){
			        Object object= rowIterator.next();
			        dataTable[listIterator.nextIndex()-1][rowIterator.nextIndex()-1] = object;
			    }
		   }
		return dataTable;
	}
	public int getColumnCount() throws SQLException{
		return resultSetMetaData.getColumnCount();
	}
	public String getProjectRoot() throws URISyntaxException {
		URL u = this.getClass().getProtectionDomain().getCodeSource().getLocation();
		File f = new File(u.toURI());
		return f.getParent();
		}

	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		connection.close();
		statement.close();
		resultSet.close();
		JOptionPane.showMessageDialog(null,
				  "Не найден класс драйвера",
				  "Ошибка при загрузке драйвера",
				  JOptionPane.ERROR_MESSAGE);
	}
}
