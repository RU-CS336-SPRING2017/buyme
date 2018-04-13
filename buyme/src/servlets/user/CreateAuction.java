package servlets.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

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
		String description = request.getParameter("description");
		String closeTime = request.getParameter("closeTime");
		String auctioneer = request.getUserPrincipal().getName();
		String title = request.getParameter("title");
		
		if (minimumPrice.equals("")) minimumPrice = null;
		
		Connection con = null;
		
		try {
			
			Database db = new Database();
			con = db.connect();
			con.setAutoCommit(false);
			con.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
			
			con.createStatement().executeUpdate(
					"INSERT INTO Auction (openTime, closeTime, initialPrice, bidIncrement, minimumPrice, description, auctioneer, subcategory, category, title) \n" +
					"VALUES ('" + LocalDateTime.now().toString() + "', '" + closeTime + "', " + initialPrice + ", " + bidIncrement + ", " + minimumPrice + ", '" + description + "', '" + auctioneer + "', '" + subcategory + "', '" + category + "', '" + title + "');"
			);
			
			ResultSet rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' AND (subcategory IS NULL OR subcategory='" + subcategory + "');");
			
			while (rs.next()) {
				
				String fieldName = rs.getString("name");
				String fieldValue = request.getParameter(fieldName);
				
				con.createStatement().executeUpdate( 
						"INSERT INTO AuctionField (auction, field, category, value) \n" +
						"VALUES (LAST_INSERT_ID(), '" + fieldName + "', '" + category + "', '" + fieldValue + "');"
				);
			}
			
			con.commit();
			
			response.sendRedirect("/buyme/user/myAuctions.jsp");
			
		} catch (ClassNotFoundException | SQLException e) {
			try { if (con != null) { con.rollback(); } } catch (SQLException e1) {}
			response.sendRedirect("/buyme/user/myAuctions.jsp?addError=" + title);
			
		} finally { try { if (con != null) { con.close(); } } catch (SQLException e) {} }
	}
}
