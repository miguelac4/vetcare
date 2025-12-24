package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VeterinarioDao {

    public String findNumLicencaByEmail(String email) {
        System.out.println("email " + email);
        String sql = "SELECT numLicenca FROM veterinario WHERE email = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            System.out.println("SELECT = " + email);


            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("numLicenca");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
