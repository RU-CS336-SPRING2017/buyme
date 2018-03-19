package servlets;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import main.*;

@WebServlet("/authenticate")
public class Authenticate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Authenticate() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (Database.isLoggedIn()) {
			response.sendRedirect(Macros.BASE_HREF);
			
		} else {

			String username = request.getParameter("username");
			String password = request.getParameter("password");

			Database db;
			
			try {
				db = new Database();
				db.logIn(username, password, response);
				
			} catch (ClassNotFoundException | SQLException e) {
				response.sendError(500, e.getMessage());
			}
		}
	}
}
