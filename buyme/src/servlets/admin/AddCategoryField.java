package servlets.admin;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.Database;

@WebServlet("/admin/AddCategoryField")
public class AddCategoryField extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddCategoryField() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("category");
		String field = request.getParameter("field");
		try {
			Database db = new Database();
			db.addCategoryField(field, category);
			response.sendRedirect("/buyme/admin/itemsEditor.jsp?category=" + category);
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/admin/itemsEditor.jsp?category=" + category + "&fieldAddError=" + field);
		}
	}

}
