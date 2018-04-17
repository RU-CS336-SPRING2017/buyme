// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla

package servlets.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/admin/RemoveSubcategoryField")
public class RemoveSubcategoryField extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RemoveSubcategoryField() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("category");
		String subcategory = request.getParameter("subcategory");
		String field = request.getParameter("field");
		try {
			Database db = new Database();
			db.removeField(category, field);
			response.sendRedirect("/buyme/admin/itemsEditor.jsp?category=" + category + "&subcategory=" + subcategory);
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/admin/itemsEditor.jsp?category=" + category + "&subcategory=" + subcategory + "&fieldRemoveError=" + field);
		}
	}

}
