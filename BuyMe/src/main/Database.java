package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

public class Database {
	
	// If username is null, user is not authenticated
	private static String username = null;

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

	/**
	 * Verifies if credentials are valid
	 */
	public void logIn(String username, String password, HttpServletResponse response) throws SQLException, IOException {

		Connection con = this.connect();
		ResultSet rs = con.createStatement()
				.executeQuery("SELECT password FROM BuyMe.Account WHERE username='" + username + "';");

		if (rs.first()) {
			String pass = rs.getString("password");
			if (pass.equals(password)) {
				Database.username = username;	
			}
		}

		con.close();
		response.sendRedirect(Macros.BASE_HREF);
	}
	
	/**
	 * Returns true if logged in
	 */
	public static boolean isLoggedIn() {
		return Database.username != null;
	}
	
	/**
	 * Logs the user out. Sets username to null, and redirects to home.
	 */
	public static void logOut(HttpServletResponse response) throws IOException {
		Database.username = null;
		response.sendRedirect(Macros.BASE_HREF);
	}
}
