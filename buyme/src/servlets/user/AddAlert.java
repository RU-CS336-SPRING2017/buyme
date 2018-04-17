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

@WebServlet("/user/AddAlert")
public class AddAlert extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddAlert() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection con = null;
		String[] param = request.getParameter("subcategroy").split("/");
		String category = param[0];
		String subcategory = param[1];
		String user = request.getUserPrincipal().getName();
		
		try {
			con = new Database().connect();
			con.createStatement().executeUpdate(
				"INSERT INTO Alert (user, category, subcategory) \n" +
				"VALUES ('" + user + "', '" + category + "', '" + subcategory + "');"
			);
			response.sendRedirect("/buyme/user/alerts.jsp");
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/user/alerts.jsp?addError");
			
		} finally {
			try {
				if (con != null) con.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

}
