// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla

package servlets.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/user/RemoveAlert")
public class RemoveAlert extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RemoveAlert() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String user = request.getUserPrincipal().getName();
		String category = request.getParameter("category");
		String subcategory = request.getParameter("subcategory");
		Connection con = null;
		
		try {
			con = new Database().connect();
			con.createStatement().executeUpdate("DELETE FROM Alert WHERE user='"+user+"' AND category='"+category+"' AND subcategory='"+subcategory+"';");
			response.sendRedirect("/buyme/user/alerts.jsp");
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/user/alerts.jsp?removeError");
			e.printStackTrace();
			
		} finally {
			if (con != null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}

}
