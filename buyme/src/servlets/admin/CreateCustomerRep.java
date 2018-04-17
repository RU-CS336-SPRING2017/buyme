// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla

package servlets.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/admin/CreateCustomerRep")
public class CreateCustomerRep extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateCustomerRep() {
        super();
    }

	/**
	 * Create a customer rep account and redirect to the page that lists the accounts
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			Database db = new Database();
			db.createCustomerRep(username, password);
			response.sendRedirect("/buyme/admin/customerRepAccounts.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/admin/customerRepAccounts.jsp?addError=" + username);
		}
	}

}
