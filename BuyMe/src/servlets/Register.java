package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

/**
 * Registers a new user using POST parameters: username and password
 */
@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			Database db = new Database();
			
			if (db.userExists(username)) {
				response.sendRedirect("/buyme/registration-error.jsp");
			} else {
				db.createUser(username, password);
				response.sendRedirect("/buyme/registration-success.jsp");
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			response.sendError(500, e.getMessage());
		}
	}

}
