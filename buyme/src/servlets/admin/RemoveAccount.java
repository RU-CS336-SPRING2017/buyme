package servlets.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/admin/RemoveAccount")
public class RemoveAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveAccount() {
        super();
    }

	/**
	 * Deletes specified user and redirects
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		try {
			Database db = new Database();
			db.removeAccount(username);
			response.sendRedirect("/buyme/admin/customerRepAccounts.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/admin/customerRepAccount.jsp?removeError" + username);
		}
	}

}
