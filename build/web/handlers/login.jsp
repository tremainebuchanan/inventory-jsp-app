<%-- 
    Document   : login
    Created on : Apr 28, 2018, 2:53:31 PM
    Author     : captain_kirk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Result</title>
    </head>
    <% 
        String email = request.getParameter("email");
    %>
    <body>
        <h1><%=email%></h1>
    </body>
</html>
