package main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

	public Database() throws ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
	}

	/**
	 * Creates a connection to the database
	 */
	private Connection connect() throws SQLException {
		return DriverManager.getConnection("jdbc:mysql://" + Macros.MYSQL_HOST + "?serverTimezone=UTC&useSSL=false",
				Macros.MYSQL_USER, Macros.MYSQL_PASS);
	}

	/**
	 * Creates a user account
	 */
	public void createUser(String username, String password) throws SQLException {
		this.createAccount(username, password, "user");
	}

	/**
	 * Creates an account
	 */
	public void createAccount(String username, String password, String type) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("INSERT INTO BuyMe.Account (username, password, type) VALUES ('" + username
				+ "', '" + password + "', '" + type + "');");
		con.close();
	}
}
