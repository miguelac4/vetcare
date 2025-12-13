package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.Clinica;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClinicaDao {

    public List<Clinica> findAll() {
        String sql = "SELECT localidade FROM clinica ORDER BY localidade";
        List<Clinica> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Clinica(rs.getString("localidade")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
