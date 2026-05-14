<%-- 
    Document   : viewUser
    Created on : May 11, 2026, 10:18:46 PM
    Author     : Legion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table >
            <tr>
                <th>UserID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role Name</th>
                <th>Created At</th>
            </tr>
            <tr>
                <c:forEach items="${userList}" var="u">
                    <td> ${u.userId}</td>
                    <td> ${u.username}</td>
                    <td> ${u.email}</td>
                    <td> ${u.role.roleName}</td>
                    <td> ${u.createdAt}</td>
                </tr>
            </c:forEach>
        </table>
        <a href="logout" class="btn btn-danger">Đăng Xuất</a>


    </body>
</html>
