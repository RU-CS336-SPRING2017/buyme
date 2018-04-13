package servlets.messages;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/messages/DeleteMessage")
public class DeleteMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteMessage() {
        super();
    }
	/**
	 *  Gets message Id, then calls to delete it
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("mId");
		try {
			Database db = new Database();
			db.deleteMessage(id);
			response.sendRedirect("/buyme/messages/messages.jsp?");
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/messages/messages.jsp");
		}
	}
}
