package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        /* =========================================================
           KHU VỰC CHUẨN BỊ DỮ LIỆU (Sẽ code ở các bước tiếp theo)
           =========================================================
           Ví dụ sau này bạn tạo SongDAO, bạn sẽ lấy nhạc ở đây:
           
           SongDAO songDAO = new SongDAO();
           List<Song> trendingSongs = songDAO.getTrendingSongs();
           request.setAttribute("listSongs", trendingSongs);
        */
        
        // Chuyển hướng tới giao diện sảnh chính
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu có Form nào ở trang chủ gửi POST (ví dụ: tạo Playlist nhanh), xử lý ở đây
        doGet(request, response);
    }
}