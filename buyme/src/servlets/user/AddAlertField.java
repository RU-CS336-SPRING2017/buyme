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

@WebServlet("/user/AddAlertField")
public class AddAlertField extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddAlertField() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String category = request.getParameter("category");
		String subcategory = request.getParameter("subcategory");
		String field = request.getParameter("field");
		String value = request.getParameter("value");
		String user = request.getUserPrincipal().getName();
		
		Connection con = null;
		
		try {
			con = new Database().connect();
			con.createStatement().executeUpdate(
				"INSERT INTO AlertField (user, category, subcategory, field, value) \n" + 
				"VALUES ('"+user+"', '"+category+"', '"+subcategory+"', '"+field+"', '"+value+"')"
			);
			response.sendRedirect("/buyme/user/alert.jsp?category=" + category + "&subcategory=" + subcategory);
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/user/alert.jsp?category=" + category + "&subcategory=" + subcategory + "&addError");
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
