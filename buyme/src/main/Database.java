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
	public Connection connect() throws SQLException {
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
	 * Creates a customer representative account
	 */
	public void createCustomerRep(String username, String password) throws SQLException {
		this.createAccount(username, password, "customerRep");
	}

	/**
	 * Creates an account
	 */
	private void createAccount(String username, String password, String type) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("INSERT INTO Account (username, password, type) VALUES ('" + username + "', '"
				+ password + "', '" + type + "');");
		con.close();
	}
	
	/**
	 * Deletes the specified account
	 */
	public void removeAccount(String username) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("DELETE FROM Account WHERE username='" + username + "';");
		con.close();
	}
	
	/**
	 * Adds a category
	 */
	public void addCategory(String category) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("INSERT INTO ItemCategory (name) VALUES ('" + category + "');");
		con.close();
	}
	
	public void addCategoryField(String field, String category) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("INSERT INTO CategoryField (name, category) VALUES ('" + field + "', '" + category + "');");
		con.close();
	}
}
