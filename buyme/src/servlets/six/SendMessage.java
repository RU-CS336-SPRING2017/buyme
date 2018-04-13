package servlets.six;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/6/SendMessage")
public class SendMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SendMessage() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String receivedBy = request.getParameter("receivedBy");
		String subject = request.getParameter("subject");
		String text = request.getParameter("text");
		String sentBy = request.getUserPrincipal().getName();
		
		Connection con = null;
		
		try {
			
			con = new Database().connect();
			con.createStatement().executeUpdate(
				"INSERT INTO Message (subject, text, dateTime, sentBy, receivedBy) \n" +
				"VALUES ('" + subject + "', '" + text + "', '" + LocalDateTime.now() + "', '" + sentBy + "', '" + receivedBy + "');"
			);
			
			response.sendRedirect("/buyme/6/messages.jsp?outbox");
			
		} catch (Exception e) {
			response.sendRedirect("/buyme/6/messages.jsp?outbox&sendError=" + receivedBy);
			
		} finally {
			try {
				con.close();
			} catch (SQLException e) { }
		}
	}

}
