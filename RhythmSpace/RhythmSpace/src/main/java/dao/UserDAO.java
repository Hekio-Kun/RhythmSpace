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
import model.User;
import utils.DBContext;

/**
 *
 * @author Legion
 */
public class UserDAO extends DBContext {

    public List<User> getAllUser() {
        List<User> list = new ArrayList();

        String sql = "SELECT * FROM users";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                
                RoleDAO roleDao = new RoleDAO();
                Role role = roleDao.getRoleById(rs.getInt("role_id"));
                Timestamp created_at = rs.getTimestamp("created_at");
                
                User user = new User(userId, username, password, email, role, created_at);
                list.add(user);
                
                
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;

    }
    
    public static void main(String[] args) {
        UserDAO userdao = new UserDAO();
        List<User> list = userdao.getAllUser();
        for (User user : list) {
            System.out.println(user);
        }
    }
}
