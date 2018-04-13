package servlets.customerRep;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/customerRep/RemoveBid")
public class RemoveBid extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public RemoveBid() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String auction = request.getParameter("auction");
		String amount = request.getParameter("amount");
		
		Connection con = null;
		
		try {
			con = new Database().connect();
			con.createStatement().executeUpdate("DELETE FROM Bid WHERE auction=" + auction + " AND amount=" + amount + ";");
			response.sendRedirect("/buyme/6/bids.jsp?auction=" + auction);
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/6/bids.jsp?auction=" + auction + "&removeError");
			e.printStackTrace();
			
		} finally {
			try {
				if (con != null) con.close();
			} catch (SQLException e) {e.printStackTrace();}
		}
	}

}
