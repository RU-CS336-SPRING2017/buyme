package main;


import java.time.LocalDateTime;
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
		return DriverManager.getConnection("jdbc:mysql://crib.qwezey.com/buymeDB?serverTimezone=UTC&useSSL=false", "root",
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
	 * Updates password of a users account
	 */
	public void changePassword(String username, String password) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("UPDATE Account SET password = '" + password + "' WHERE username = '" 
				+ username + "';");
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
	public void deleteMessage(String mId) throws SQLException {
		Connection con = this.connect();
		con.createStatement().execute("DELETE FROM Message WHERE id=" + mId + ";");
		con.close();
	}
	public void compose(String sentTo, String sentBy, String subject, String text) throws SQLException {
		Connection con = this.connect();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
		LocalDateTime now = LocalDateTime.now();
		con.createStatement().execute("INSERT INTO Message (id, subject, text, dateTime, sentBy, sentTo)" +
					" VALUES (DEFAULT, '" + subject + "', '" + text + "', '" + dtf.format(now) + "', '" + sentBy + "', '" + sentTo + "');");
		con.close();
	}
	public BigDecimal getCurrentBid(String auctionId) throws SQLException {
		Connection con = this.connect();
		con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
		con.setAutoCommit(false);
		ResultSet rs = con.createStatement().executeQuery("SELECT initialPrice FROM Auction WHERE id =" + auctionId);
		rs.next();
		BigDecimal ret = rs.getBigDecimal("initialPrice");
		rs = con.createStatement().executeQuery("SELECT MAX(amount) max FROM Bid WHERE auction=" + auctionId);
		rs.next();
		BigDecimal maxBid = rs.getBigDecimal("max");
		if (maxBid != null) {
			if (maxBid.compareTo(ret) > 0) {
				ret = maxBid;
			}
		}
		con.commit();
		con.close();
		return ret;
	}
}
