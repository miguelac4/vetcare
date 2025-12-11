package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.Animal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnimalDao {

    public List<Animal> findAll() throws SQLException {

        String sql = "SELECT idAnimal, nome, raca, sexo FROM Animal";
        List<Animal> animais = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Animal a = new Animal(
                        rs.getInt("idAnimal"),
                        rs.getString("nome"),
                        rs.getString("raca"),
                        rs.getString("sexo")
                );
                animais.add(a);
            }
        }

        return animais;
    }
}
