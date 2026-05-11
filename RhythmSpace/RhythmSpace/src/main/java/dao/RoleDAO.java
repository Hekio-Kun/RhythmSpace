/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Role;
import utils.DBContext;

/**
 *
 * @author Legion
 */
public class RoleDAO extends DBContext {

    public List<Role> getAllRole() {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM roles";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");

                Role role = new Role(id, name);
                list.add(role);

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Role getRoleById(int roleId) {
        String sql = "SELECT * FROM roles where id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Role(roleId, rs.getString("name"));
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        RoleDAO dao = new RoleDAO();
        List<Role> list = dao.getAllRole();
        for (Role role :  list) {
            System.out.println(role);
        }
        
        System.out.println("-------------------------------");
        Role role = dao.getRoleById(1);
        System.out.println(role);
    }
}
