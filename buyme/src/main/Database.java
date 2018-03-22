package main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database {

	public Database() throws ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
	}

	/**
	 * Creates a connection to the database
	 */
	private Connection connect() throws SQLException {
		return DriverManager.getConnection("jdbc:mysql://crib.qwezey.com/BuyMe?serverTimezone=UTC&useSSL=false", "root",
				"password");
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
		con.createStatement().execute("INSERT INTO Account (username, password, type) VALUES ('" + username + "', '"
				+ password + "', '" + type + "');");
		con.close();
	}
	
	/**
	 * Returns true if username exists in the database
	 */
	public boolean userExists(String username) throws SQLException {
		Connection con = this.connect();
		ResultSet rs = con.createStatement().executeQuery("SELECT * FROM Account WHERE username='" + username + "';");
		boolean ret = rs.first();
		con.close();
		return ret;
	}
}
