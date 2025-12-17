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

    public List<Cliente> searchByNome(String prefixo, int limit) {
        String sql = "SELECT nif, nome, email FROM cliente " +
                "WHERE nome LIKE ? ORDER BY nome LIMIT ?";

        List<Cliente> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, prefixo + "%");
            ps.setInt(2, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setNif(rs.getString("nif"));
                    c.setNome(rs.getString("nome"));
                    c.setEmail(rs.getString("email"));
                    list.add(c);
                }
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

    public void update(Cliente c) {
        String sql = """
        UPDATE cliente SET
            nome = ?,
            sexo = ?,
            telefone = ?,
            email = ?,
            morada = ?,
            freguesia = ?,
            concelho = ?,
            capitalSocial = ?
        WHERE nif = ?
        """;

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getNome());
            ps.setString(2, c.getSexo());
            ps.setString(3, c.getTelefone());
            ps.setString(4, c.getEmail());
            ps.setString(5, c.getMorada());
            ps.setString(6, c.getFreguesia());
            ps.setString(7, c.getConcelho());

            if (c.getCapitalSocial() == null)
                ps.setNull(8, java.sql.Types.DOUBLE);
            else
                ps.setDouble(8, c.getCapitalSocial());

            ps.setString(9, c.getNif());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
