package servlets.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/user/CreateAuction")
public class CreateAuction extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CreateAuction() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String category = request.getParameter("category");
		String subcategory = request.getParameter("subcategory");
		String initialPrice = request.getParameter("initialPrice");
		String bidIncrement = request.getParameter("bidIncrement");
		String minimumPrice = request.getParameter("minimumPrice");
		String closeTime = request.getParameter("closeTime");
		String auctioneer = request.getUserPrincipal().getName();
		
		Connection con;
		
		try {
			
			Database db = new Database();
			con = db.connect();
			
			con.setAutoCommit(false);
			con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
			
			
			ResultSet rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' AND (subcategory IS NULL OR subcategory='" + subcategory + "');");
			
			con.createStatement().execute(
					"INSERT INTO Auction (openTime, closeTime, initialPrice, bidIncrement, auctioneer, subcategory, category) \n" +
					"VALUES ('2018-03-03T10:24', '" + closeTime + "', " + initialPrice + ", " + bidIncrement + ", '" + auctioneer + "', '" + subcategory + "', '" + category + "');"
			);
			
			while (rs.next()) {
				
				String fieldName = rs.getString("name");
				String fieldValue = request.getParameter(fieldName);
				
				con.createStatement().execute( 
						"INSERT INTO AuctionField (auction, field, category, value) \n" +
						"VALUES (LAST_INSERT_ID(), '" + fieldName + "', '" + category + "', '" + fieldValue + "');"
				);
			}
			
			con.commit();
			con.close();
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
}
