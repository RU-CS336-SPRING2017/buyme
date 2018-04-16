package servlets.customerRep;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/customerRep/AnswerQuestion")
public class AnswerQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AnswerQuestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String answer = request.getParameter("answer");
		
		Connection con = null;
		
		try {
			con = new Database().connect();
			con.createStatement().executeUpdate("UPDATE Question SET answer='"+answer+"' WHERE id="+id+"");
			response.sendRedirect("/buyme/6/questions.jsp");
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/6/questions.jsp?answerError");
			
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
