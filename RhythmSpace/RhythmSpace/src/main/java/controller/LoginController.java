package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng người dùng tới trang login.jsp khi họ gõ URL /login
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.checkLogin(username, password);
        
        HttpSession session = request.getSession();
        
        if (user == null) {
            // Đăng nhập THẤT BẠI
            // Lưu câu thông báo lỗi vào session tạm thời
            session.setAttribute("errorMsg", "Sai tài khoản hoặc mật khẩu!");
            // Đẩy ngược lại về trang login
            response.sendRedirect("login"); 
        } else {
            // Đăng nhập THÀNH CÔNG
            // Cất toàn bộ đối tượng 'user' vào chiếc tủ Session mang tên "account"
            session.setAttribute("account", user);
            
            // Chuyển hướng sang trang danh sách người dùng của bạn
            response.sendRedirect("home");
        }
    }
}