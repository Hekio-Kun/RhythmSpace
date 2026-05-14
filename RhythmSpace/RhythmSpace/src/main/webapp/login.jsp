<%-- 
    Document   : login
    Created on : May 14, 2026, 4:33:40 PM
    Author     : Legion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="login" method="post">
            <label>Username</label>
            <input type="text" name="username"/>
            
            <label>Password</label>
            <input type="text" name="password"/>
            
            <button type="submit">Log in</button>
        </form>
    </body>
</html>
