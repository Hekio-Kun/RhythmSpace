/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
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
    public static void main(String[] args) {
        
        UserDAO userDao = new UserDAO();
        List<User> list = userDao.getAllUser();
        for (User user : list) {
            System.out.println(user);
        }
        
    }
}
