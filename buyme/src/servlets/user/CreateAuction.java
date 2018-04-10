package servlets.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.fabric.xmlrpc.base.Array;

import main.Database;

@WebServlet("/user/CreateAuction")
public class CreateAuction extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CreateAuction() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String[] staticParameters = {
				"category",
				"subcategory",
				"initialPrice",
				"bidIncrement",
				"minimumPrice",
				"closeTime"
		};
		
		String category = request.getParameter("category");
		String subcategory = request.getParameter("subcategory");
		String initialPrice = request.getParameter("initialPrice");
		String bidIncrement = request.getParameter("bidIncrement");
		String minimumPrice = request.getParameter("minimumPrice");
		String closeTime = request.getParameter("closeTime");
		String auctioneer = request.getUserPrincipal().getName();
//		
//		Enumeration<String> parameters = request.getParameterNames();
//		
//		System.out.println("This is the test");
//		while (parameters.hasMoreElements()) {
//			if (staticParameters.)
//			System.out.println(parameters.nextElement());
//		}
		
		try {
			
			Database db = new Database();
			Connection con = db.connect();
			ResultSet rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' AND (subcategory IS NULL OR subcategory='" + subcategory + "');");
			
			String createAuction =
					"START TRANSACTION; \n" + 
					"INSERT INTO Auction (openTime, closeTime, initialPrice, bidIncrement, auctioneer, subcategory, category) \n" +
					"VALUES ('2018-03-03T10:24', '" + closeTime + "', " + initialPrice + ", " + bidIncrement + ", '" + auctioneer + "', '" + subcategory + "', '" + category + "'); \n";
			
			while (rs.next()) {
				
				String fieldName = rs.getString("name");
				String fieldValue = request.getParameter(fieldName);
				
				createAuction += 
						"INSERT INTO AuctionField (auction, field, category, value); \n" +
						"VALUES (LAST_INSERT_ID(), '" + fieldName + "', '" + category + "', '" + fieldValue + "'); \n";
			}
			
			createAuction += "COMMIT;";
			
			con.createStatement().execute(createAuction);
			con.close();
			System.out.println("Worked!");
			
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("Didnt!" + e.getMessage());
		}
	}

}
