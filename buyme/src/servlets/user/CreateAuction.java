// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla

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
					"INSERT INTO Auction (closeTime, initialPrice, bidIncrement, minimumPrice, description, auctioneer, subcategory, category, title) \n" +
					"VALUES ('" + closeTime + "', " + initialPrice + ", " + bidIncrement + ", " + minimumPrice + ", '" + description + "', '" + auctioneer + "', '" + subcategory + "', '" + category + "', '" + title + "');"
			);
			
			ResultSet rs = con.createStatement().executeQuery("SELECT LAST_INSERT_ID() id;");
			rs.next();
			long auctionId = rs.getLong("id");
			
			rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' AND (subcategory IS NULL OR subcategory='" + subcategory + "');");
			
			while (rs.next()) {
				
				String fieldName = rs.getString("name");
				String fieldValue = request.getParameter(fieldName);
				
				con.createStatement().executeUpdate( 
						"INSERT INTO AuctionField (auction, field, category, value) \n" +
						"VALUES ("+auctionId+", '" + fieldName + "', '" + category + "', '" + fieldValue + "');"
				);
			}
			
			rs = con.createStatement().executeQuery("SELECT user FROM Alert WHERE category='"+category+"' AND subcategory='"+subcategory+"';");
			
			while (rs.next()) {
				
				String user = rs.getString("user");
				String query =
						"INSERT INTO Message (subject, text, sentBy, receivedBy) \n" + 
						"VALUES ('"+subcategory+" Alert', 'Your alert for "+category+"/"+subcategory+" has been auctioned as <a href=\"/buyme/6/auction.jsp?id="+auctionId+"\">"+title+"</a>', 'admin', '"+user+"');";
				
				ResultSet rs2 = con.createStatement().executeQuery("SELECT field, value FROM AlertField WHERE user='"+user+"' AND category='"+category+"' AND subcategory='"+subcategory+"';");
				
				if (rs2.next()) {
					
					do {

						String field = rs2.getString("field");
						String alertValue = rs2.getString("value");
						String insertValue = request.getParameter(field);
						
						if (alertValue.equals(insertValue)) {
							con.createStatement().executeUpdate(
								"INSERT INTO Message (subject, text, sentBy, receivedBy) \n" + 
								"VALUES ('"+subcategory+" Alert', 'Your alert for "+category+"/"+subcategory+" has been auctioned as <a href=\"/buyme/6/auction.jsp?id="+auctionId+"\">"+title+"</a> where "+field+" = "+alertValue+"', 'admin', '"+user+"');"
							);
						}
						
					} while (rs2.next());
					
				} else {
					con.createStatement().executeUpdate(
						"INSERT INTO Message (subject, text, sentBy, receivedBy) \n" + 
						"VALUES ('"+subcategory+" Alert', 'Your alert for "+category+"/"+subcategory+" has been auctioned as <a href=\"/buyme/6/auction.jsp?id="+auctionId+"\">"+title+"</a>', 'admin', '"+user+"');"
					);
				}
			}
			
			con.commit();
			
			response.sendRedirect("/buyme/user/myAuctions.jsp");
			
		} catch (ClassNotFoundException | SQLException e) {
			try { if (con != null) { con.rollback(); } } catch (SQLException e1) {}
			response.sendRedirect("/buyme/user/myAuctions.jsp?addError=" + title);
			e.printStackTrace();
			
		} finally { try { if (con != null) { con.close(); } } catch (SQLException e) {} }
	}
}
