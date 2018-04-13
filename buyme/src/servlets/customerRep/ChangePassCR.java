package servlets.customerRep;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/customerRep/ChangePassCR")
public class ChangePassCR extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ChangePassCR() {
        super();
    }

	/**
	 *  Changes the password of a user the redirects
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			Database db = new Database();
			db.changePassword(username, password);
			response.sendRedirect("/buyme/customerRep/userAccountManager.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/customerRep/userAccountManager.jsp?updateError=" + username);
		}
	}

}

