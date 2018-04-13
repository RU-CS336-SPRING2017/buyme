package servlets.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/user/Bid")
public class Bid extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Bid() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String amount = request.getParameter("amount");
		String type = request.getParameter("type");
		String auction = request.getParameter("auction");
		String bidder = request.getUserPrincipal().getName();
		
		Connection con = null;
		
		try {
			
			con = new Database().connect();
			
			if (type.equals("auto")) {
				
			} else if (type.equals("manual")) {
				
				con.createStatement().executeUpdate(
					"INSERT INTO Bid (dateTime, amount, bidder, auction)" +
					"VALUES ('" + LocalDateTime.now().toString() + "', '" + amount + "', '" + bidder + "', '" + auction + "');"
				);
			}
			
			response.sendRedirect("/buyme/6/auction.jsp?id=" + auction);
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/6/auction.jsp?id=" + auction + "&bidError=" + amount);
		} finally {
			try {
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
