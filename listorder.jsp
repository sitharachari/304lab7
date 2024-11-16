<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try ( Connection con = DriverManager.getConnection(url, uid, pw); ) {
    // Create statement
    Statement stmt = con.createStatement();

    
    String orderQuery= "SELECT o.orderId, o.orderDate, o.customerId, c.firstName, c.lastName, o.totalAmount FROM ordersummary as o join customer as c on o.customerId = c.customerId";
	String productQuery = "select productId, quantity, price from orderproduct where orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(productQuery);
	ResultSet rst = stmt.executeQuery(orderQuery);
	//out.println("Bleh\n");

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	out.println("<table border = 1><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th><th>Products</th></tr>");
	while (rst.next()) {
		String orderId = rst.getString(1);
		double totalAmount = rst.getDouble(6);

		out.println("<tr>");
		out.println("<td>" + orderId + "</td>");
		out.println("<td>" + rst.getDate(2) + "</td>");
		out.println("<td>" + rst.getString(3) + "</td>");
		out.println("<td>" + rst.getString(4) + " " + rst.getString(5) + "</td>");
		out.println("<td>" + currFormat.format(totalAmount) + "</td>");

		out.println("<td><table border='1'><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");

		pstmt.setString(1, orderId);
		ResultSet prst = pstmt.executeQuery();

		while (prst.next()) {
			out.println("<tr>");
			out.println("<td>" + prst.getString(1) + "</td>");
			out.println("<td>" + prst.getInt(2) + "</td>");
			out.println("<td>" + prst.getBigDecimal(3) + "</td>");
			out.println("</tr>");
		}

		out.println("</table></td></tr>");
	}

	out.println("</table>");


	}
catch (Exception e){
    out.print(e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

