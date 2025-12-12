package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.Cliente;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClienteDao {

    public List<Cliente> findAllClients() {
        String sql = "SELECT nif, nome, email FROM cliente ORDER BY nome";

        List<Cliente> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setNif(rs.getString("nif"));
                c.setNome(rs.getString("nome"));
                c.setEmail(rs.getString("email"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Cliente findFichaClientByNif(String nif) {
        String sql = "SELECT * FROM cliente WHERE nif = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nif);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Cliente c = new Cliente();
                    c.setNif(rs.getString("nif"));
                    c.setNome(rs.getString("nome"));
                    c.setSexo(rs.getString("sexo"));
                    c.setTelefone(rs.getString("telefone"));
                    c.setEmail(rs.getString("email"));
                    c.setMorada(rs.getString("morada"));
                    c.setFreguesia(rs.getString("freguesia"));
                    c.setConcelho(rs.getString("concelho"));

                    // pode ser NULL (empresa tem, pessoas não)
                    double cs = rs.getDouble("capitalSocial");
                    c.setCapitalSocial(rs.wasNull() ? null : cs);

                    return c;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
