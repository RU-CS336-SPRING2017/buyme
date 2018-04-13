package servlets.user;

import java.io.IOException;
import java.math.BigDecimal;
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
				
				con.createStatement().executeUpdate(
						"INSERT INTO AutoBid (max, bidder, auction) \n" +
						"VALUES ('" + amount + "', '" + bidder + "', '" + auction + "');"
					);
				
			} else if (type.equals("manual")) {
				
				con.setAutoCommit(false);
				
				con.createStatement().executeUpdate(
					"INSERT INTO Bid (amount, bidder, auction) \n" +
					"VALUES ('" + amount + "', '" + bidder + "', '" + auction + "');"
				);
				
				ResultSet rs = con.createStatement().executeQuery("SELECT bidIncrement FROM Auction WHERE id=" + auction +";");
				rs.next();
				BigDecimal bidIncrement = rs.getBigDecimal("bidIncrement");
				BigDecimal nextBid = bidIncrement.add(new BigDecimal(amount));
				
				rs = con.createStatement().executeQuery("SELECT bidder FROM AutoBid WHERE max >= " + nextBid + ";");
				if (rs.next()) {
					String newBidder = rs.getString("bidder");
					con.createStatement().executeUpdate(
						"INSERT INTO Bid (amount, bidder, auction) \n" +
						"VALUES (" + nextBid + ", '" + newBidder + "', " + auction + ")"
					);
				}
				
				con.commit();
			}
			
			response.sendRedirect("/buyme/6/auction.jsp?id=" + auction);
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/6/auction.jsp?id=" + auction + "&bidError=" + amount);
			try {
				if (!con.getAutoCommit()) {
					con.rollback();
				}
				e.printStackTrace();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
