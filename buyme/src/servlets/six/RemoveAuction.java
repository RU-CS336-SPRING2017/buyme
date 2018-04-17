// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla

package servlets.six;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/6/RemoveAuction")
public class RemoveAuction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveAuction() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		Connection con = null;
		
		try {
			
			Database db = new Database();
			con = db.connect();
			
			if (request.isUserInRole("customerRep")) {
				con.createStatement().executeUpdate("DELETE FROM Auction WHERE id='" + id +"';");
				response.sendRedirect("/buyme/6/auctions.jsp");
				
			} else {
				con.createStatement().executeUpdate("DELETE FROM Auction WHERE id='" + id +"' AND auctioneer='" + request.getUserPrincipal().getName() + "';");
				response.sendRedirect("/buyme/user/myAuctions.jsp");
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			
			if (request.isUserInRole("customerRep")) {
				response.sendRedirect("/buyme/6/auctions.jsp?removeError=" + id);
				
			} else {
				response.sendRedirect("/buyme/user/myAuctions.jsp?removeError=" + id);
			}
			
		} finally { try { if (con != null) { con.close(); } } catch (SQLException e) {} }
	}
}
