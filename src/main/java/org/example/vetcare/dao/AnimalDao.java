package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.Animal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class AnimalDao {

    public List<Animal> findAllByNif(String nif) {
        String sql = "SELECT * FROM animal WHERE nif = ? ORDER BY nome";

        List<Animal> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nif);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Animal a = new Animal();
                    a.setIdAnimal(rs.getInt("idAnimal"));
                    a.setNome(rs.getString("nome"));
                    a.setRaca(rs.getString("raca"));
                    a.setSexo(rs.getString("sexo"));

                    Date dn = rs.getDate("dataNascimento");
                    a.setDataNascimento(dn == null ? null : dn.toLocalDate());

                    a.setFiliacao(rs.getString("filiacao"));
                    a.setEstadoReprodutivo(rs.getString("estadoReprodutivo"));
                    a.setAlergia(rs.getString("alergia"));
                    a.setCor(rs.getString("cor"));
                    a.setFotografia(rs.getString("fotografia"));

                    double peso = rs.getDouble("peso");
                    a.setPeso(rs.wasNull() ? null : peso);

                    a.setDistintivas(rs.getString("distintivas"));
                    a.setNumChip(rs.getString("numChip"));
                    a.setNif(rs.getString("nif"));

                    list.add(a);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
