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

@WebServlet("/user/AskQuestion")
public class AskQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AskQuestion() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String question = request.getParameter("question");
		
		Connection con = null;
		
		try {
			con = new Database().connect();
			con.createStatement().executeUpdate("INSERT INTO Question (question) VALUES ('"+question+"');");
			response.sendRedirect("/buyme/6/questions.jsp");
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/6/questions.jsp?askError");
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
