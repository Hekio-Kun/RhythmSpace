/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

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
