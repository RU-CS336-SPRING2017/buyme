package servlets.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/admin/RemoveSubategory")
public class RemoveSubategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveSubategory() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("category");
		String subcategory = request.getParameter("subcategory");
		try {
			Database db = new Database();
			db.removeSubcategory(subcategory, category);
			response.sendRedirect("/buyme/admin/itemsEditor.jsp?category=" + category);
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/admin/itemsEditor.jsp?category=" + category + "&subcategory=" + subcategory + "&subcategoryRemoveError=true");
		}
	}
}
