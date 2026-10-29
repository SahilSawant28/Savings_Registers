<%@ page import="java.sql.*" %>

<html>
<head>
    <title></title>
</head>
<body>

<h2>Saved! All Records</h2>

<table border="1" align="center" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Member</th>
        <th>Month</th>
        <th>Amount</th>
    </tr>

<%
    String url = "jdbc:mysql://localhost:3306/savingsdb";
    String user = "root";
    String password = "Daisy@1234";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con =
            DriverManager.getConnection(url, user, password);

        // Save the new record
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String member = request.getParameter("member");
            String month = request.getParameter("month");
            int amount = Integer.parseInt(
                request.getParameter("amount")
            );

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO shg_savings (member, month, amount) VALUES (?, ?, ?)"
            );

            ps.setString(1, member);
            ps.setString(2, month);
            ps.setInt(3, amount);
            ps.executeUpdate();
            ps.close();
        }

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
            "SELECT * FROM shg_savings"
        );

        int total = 0;

        while (rs.next()) {
            int amount = rs.getInt("amount");
            total = total + amount;
%>

    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("member") %></td>
        <td><%= rs.getString("month") %></td>
        <td><%= amount %></td>
    </tr>

<%
        }
%>

    <tr>
        <td colspan="4">
            Total Amount: Rs. <%= total %>
        </td>
    </tr>

<%
        rs.close();
        st.close();
        con.close();

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

</table>

<p align="center">
    <a href="index.html">Add Another Record</a>
</p>

</body>
</html>
