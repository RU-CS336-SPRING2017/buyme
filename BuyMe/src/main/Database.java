package main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database {
	
	public static boolean loggedIn;
	public static String username;
	
	public Database() throws ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
	}

	/**
	 * Creates a connection to the database
	 */
	private Connection connect() throws SQLException {
		return DriverManager.getConnection("jdbc:mysql://localhost?serverTimezone=UTC&useSSL=false", "root",
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
		con.createStatement().execute("INSERT INTO BuyMe.Account (username, password, type) VALUES ('" + username
				+ "', '" + password + "', '" + type + "');");
		con.close();
	}

	/**
	 * Verifies if credentials are valid
	 */
	public boolean verifyUser(String username, String password) throws SQLException {

		boolean ret;
		Connection con = this.connect();
		ResultSet rs = con.createStatement()
				.executeQuery("SELECT password FROM BuyMe.Account WHERE username='" + username + "';");

		if (rs.first()) {
			String pass = rs.getString("password");
			if (pass.equals(password)) {
				ret = true;
			} else {
				ret = false;
			}

		} else {
			ret = false;
		}

		con.close();
		return ret;
	}
}
