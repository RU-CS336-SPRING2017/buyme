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

@WebServlet("/admin/RemoveCategory")
public class RemoveCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RemoveCategory() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("category");
		try {
			Database db = new Database();
			db.removeCategory(category);
			response.sendRedirect("/buyme/admin/itemsEditor.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			response.sendRedirect("/buyme/admin/itemsEditor.jsp?category=" + category + "&categoryRemoveError=true");
		}
	}

}
