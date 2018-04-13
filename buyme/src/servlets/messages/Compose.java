package servlets.messages;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/messages/Compose")
public class Compose extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Compose() {
        super();
      
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sentBy = request.getParameter("sentBy");
		String sentTo = request.getParameter("sentTo");
		String subject = request.getParameter("subject");
		String text = request.getParameter("text");
		try {
			Database db = new Database();
			db.compose(sentTo, sentBy, subject, text);
			response.sendRedirect("/buyme/messages/messages.jsp?success=Message sent!");
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/messages/compose.jsp?addError=" + sentTo);
		}
	}

}
