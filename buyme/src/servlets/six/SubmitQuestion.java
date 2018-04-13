package servlets.six;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

/**
 * Servlet implementation class SubmitQuestion
 */
@WebServlet("/6/SubmitQuestion")
public class SubmitQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SubmitQuestion() {
        super();
       
    }

	/**
	 * Submits a question about an auction
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aucId = request.getParameter("aucId");
		String text = request.getParameter("text");
		try {
			Database db = new Database();
			db.submitQuestion(aucId, text);
			response.sendRedirect("/buyme/6/auction.jsp?id=" + aucId);
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/6/auction.jsp?id="+ aucId);
		}
	}

}
