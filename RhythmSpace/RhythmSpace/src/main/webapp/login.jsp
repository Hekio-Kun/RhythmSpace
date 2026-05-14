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
        <link href="bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container" style="display: flex; align-items: center; justify-content: center" >
            <form class="border p-3 mt-3" style="border-radius: 10px; " action="login" method="post">
                <h3 class="text-center">Login</h3>
            <label class="form-label">Username</label>
            <input class="form-control" type="text" name="username"/>
            
            <label class="form-label">Password</label>
            <input class="form-control" type="text" name="password"/>
            
            <button class="btn btn-primary mt-3" type="submit">Log in</button>
        </form>
        </div>
    </body>
</html>
