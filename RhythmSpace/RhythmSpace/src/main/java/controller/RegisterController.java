package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.EmailUtils;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        // 1. Kiểm tra 2 mật khẩu có khớp nhau không
        if (!password.equals(repassword)) {
            request.setAttribute("errorMsg", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 2. Kiểm tra xem User/Email đã tồn tại trong DB chưa
        UserDAO dao = new UserDAO();
        if (dao.checkUserExist(username, email)) {
            request.setAttribute("errorMsg", "Tên tài khoản hoặc Email đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Xử lý Gửi OTP
        // Tạo ra mã 6 số
        String otpCode = EmailUtils.generateOTP(); 
        
        // Gửi mail cho người dùng
        boolean isSend = EmailUtils.sendEmail(email, otpCode);

        if (isSend) {
            // Nếu gửi mail thành công, ta LƯU TẠM thông tin vào Session
            HttpSession session = request.getSession();
            session.setAttribute("tempUsername", username);
            session.setAttribute("tempEmail", email);
            session.setAttribute("tempPassword", password); // Vẫn là raw pass, lát nữa verify xong mới băm
            session.setAttribute("otpCode", otpCode); // Lưu mã OTP để lát nữa so sánh

            // Chuyển người dùng sang trang nhập mã xác minh
            response.sendRedirect("verify.jsp");
        } else {
            // Nếu gửi mail lỗi (VD: sai địa chỉ mail)
            request.setAttribute("errorMsg", "Lỗi hệ thống: Không thể gửi email xác minh.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}