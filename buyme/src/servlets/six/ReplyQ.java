package servlets.six;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/6/ReplyQ")
public class ReplyQ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReplyQ() {
        super();
    }

	/**
	 * Submits a reply to a specific question in a specific auction
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aucId = request.getParameter("aucId");
		String qId = request.getParameter("qId");
		String text = request.getParameter("text");
		try {
			Database db = new Database();
			db.replyQuestion(qId, text);
			response.sendRedirect("/buyme/6/auction.jsp?id=" + aucId);
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/6/auction.jsp?id="+ aucId);
		}
	}

}
