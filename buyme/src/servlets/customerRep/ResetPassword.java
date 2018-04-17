// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla

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

@WebServlet("/customerRep/ResetPassword")
public class ResetPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ResetPassword() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Connection con = null;
		
		try {
			con = new Database().connect();
			con.createStatement().executeUpdate("UPDATE Account SET password='" + password + "' WHERE username='" + username + "';");
			response.sendRedirect("/buyme/customerRep/users.jsp");
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/customerRep/users.jsp?resetError=" + username);
			
		} finally {
			try {
				if (con != null) con.close();
			} catch (SQLException e) {}
		}
	}

}
