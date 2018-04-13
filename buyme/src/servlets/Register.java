package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Register() {
        super();
    }

    /**
     * Registers a new user using POST parameters: username and password
     */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			Database db = new Database();
			db.createUser(username, password);
			response.sendRedirect("/buyme/?registrationSuccess=" + username);
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/register.jsp?registrationError=" + username);
		}
	}

}
