package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutController", urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Gọi tủ đồ Session hiện tại ra
        HttpSession session = request.getSession();
        
        // Lệnh invalidate() sẽ XÓA SẠCH toàn bộ Session (xé nhãn "account")
        session.invalidate();
        
        // Đuổi người dùng về lại trang đăng nhập
        response.sendRedirect("home");
    }
}