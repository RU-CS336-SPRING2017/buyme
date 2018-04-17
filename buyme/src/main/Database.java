// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla

package main;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;

public class Database {
	
	public static String timestampString(Timestamp time) {
		return time.toLocalDateTime().format(
			DateTimeFormatter.ofLocalizedDateTime(
				FormatStyle.MEDIUM,
				FormatStyle.SHORT
			)
		);
	}

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
	
	public void removeCategory(String category) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("DELETE FROM ItemCategory WHERE name='" + category + "';");
		con.close();
	}
	
	public void addCategoryField(String field, String category) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("INSERT INTO CategoryField (name, category) VALUES ('" + field + "', '" + category + "');");
		con.close();
	}
	
	public void addSubcategory(String subcategory, String category) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("INSERT INTO ItemSubcategory (name, category) VALUES ('" + subcategory + "', '" + category + "');");
		con.close();
	}
	
	public void removeSubcategory(String subcategory, String category) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("DELETE FROM ItemSubcategory WHERE name='" + subcategory + "' AND category='" + category + "';");
		con.close();
	}
	
	public void addSubcategoryField(String field, String subcategory, String category) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("INSERT INTO CategoryField (name, category, subcategory) VALUES ('" + field + "', '" + category + "', '" + subcategory + "');");
		con.close();
	}
	
	public void removeField(String category, String field) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("DELETE FROM CategoryField WHERE category='" + category + "' AND name='" + field + "';");
		con.close();
	}
	
	public String getCurrentBid(String auctionId) throws SQLException {
		Connection con = this.connect();
		String ret = "No bids";
		ResultSet rs = con.createStatement().executeQuery("SELECT MAX(amount) max FROM Bid WHERE auction=" + auctionId);
		rs.next();
		String price = rs.getString("max");
		if (price != null) ret = "$" + price;
		con.close();
		return ret;
	}
}
