<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.User" %>
<html>
<head>
    <title>Search Users</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>Search Users</h1>
        <form action="SearchServlet" method="get">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" id="username" name="username">
            </div>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
        <%
            User user = (User) request.getAttribute("user");
            if (user != null) {
        %>
        <h2>User Details</h2>
        <p>User ID: <%= user.getUserId() %></p>
        <p>Username: <%= user.getUsername() %></p>
        <p>Email: <%= user.getEmail() %></p>
        <a href="EditServlet?userId=<%= user.getUserId() %>" class="btn btn-secondary">Edit</a>
        <a href="DeleteServlet?userId=<%= user.getUserId() %>" class="btn btn-danger">Delete</a>
        <%
            } else if (request.getParameter("username") != null) {
                out.println("<p>User not found.</p>");
            }
        %>
    </div>
</body>
</html>