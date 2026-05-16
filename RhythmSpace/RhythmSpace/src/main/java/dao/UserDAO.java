/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Role;
import utils.DBContext;
import model.User;

/**
 *
 * @author lehai
 */
public class UserDAO extends DBContext {

    public String hashMD5(String str) {
        try {
            MessageDigest mes = MessageDigest.getInstance("MD5");
            byte[] messMD5 = mes.digest(str.getBytes());
            //[0x0a, 0x7a, 0x12, 0x09]
            StringBuilder result = new StringBuilder();
            for (byte b : messMD5) {
                //0x0a 0x7a; 0x12 0x09 0x3
                String c = String.format("%02x", b);
                //0a; 7a 12 09 03
                result.append(c);
            }
            return result.toString();
        } catch (Exception e) {
        }

        return "";
    }

    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                RoleDAO roleDao = new RoleDAO();
                Role role = roleDao.getRoleById(rs.getInt("id"));
                Timestamp createAt = rs.getTimestamp("created_at");

                User user = new User(id, username, password, email, role, createAt);
                list.add(user);

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;

    }

    public User checkLogin(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hashMD5(password));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String email = rs.getString("email");
                RoleDAO roleDao = new RoleDAO();
                Role role = roleDao.getRoleById(rs.getInt("id"));
                Timestamp createAt = rs.getTimestamp("created_at");

                User user = new User(id, username, password, email, role, createAt);
                return user;
            }

        } catch (Exception e) {
            System.out.println("Fail to check login" + e.getMessage());
        }
        return null;
    }

    // Hàm 1: Kiểm tra xem username hoặc email đã bị người khác dùng chưa
    public boolean checkUserExist(String username, String email) {
        String sql = "SELECT * FROM users WHERE username = ? OR email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true; // Trả về true nghĩa là ĐÃ BỊ TRÙNG
            }
        } catch (Exception e) {
            System.out.println("Lỗi checkUserExist: " + e.getMessage());
        }
        return false; // Chưa ai dùng, an toàn!
    }

    public boolean addNewUser(String username, String password, String email, int roleId, String Fullname, String phone, String address, boolean gender, Date dob) {
        String sql = "INSERT INTO [dbo].[users] "
                + "           ([username] "
                + "           ,[password] "
                + "           ,[email] "
                + "           ,[role_id] "
                + "           ,[FullName] "
                + "           ,[Phone] "
                + "           ,[Address] "
                + "           ,[Gender] "
                + "           ,[Dob]) "
                + "     VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setInt(4, roleId);
            ps.setString(5, Fullname);
            ps.setString(6, phone);
            ps.setString(7, address);
            ps.setBoolean(8, gender);
            ps.setDate(9, dob);
            
            int n = ps.executeUpdate();
            if(n > 0){
                return true;
            }
            
        } catch (Exception e) {
            System.out.println("Fail to add new user: " +e.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {

        UserDAO userDao = new UserDAO();
        List<User> list = userDao.getAllUser();
        for (User user : list) {
            System.out.println(user);
        }

        System.out.println(userDao.hashMD5("123"));
        
        String username = "luke";
        String password = userDao.hashMD5("123");
        String email = "luke@gmail.com";
        int roleId = 1;
        String fullname = "Nguyen An Binh";
        String phone = "012345678";
        String address = "HCM";
        boolean gender = true;
        Date dob = Date.valueOf("2006-06-11");
        
        boolean addSuccess = userDao.addNewUser(username, password, email, roleId, fullname, phone, address, gender, dob);
        if(addSuccess){
            System.out.println("Add successfully!");
        }
        
    }
}
