<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.User" %>
<html>
<head>
    <title>Edit User</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>Edit User</h1>
        <%
            User user = (User) request.getAttribute("user");
            if (user != null) {
        %>
        <form action="UpdateServlet" method="post">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" id="username" name="username" value="<%= user.getUsername() %>" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" value="<%= user.getPassword() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
        <%
            } else {
                out.println("<p>User not found.</p>");
            }
        %>
    </div>
</body>
</html>