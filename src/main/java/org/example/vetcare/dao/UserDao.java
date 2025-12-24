package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.User;
import org.example.vetcare.model.Veterinario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public User findByEmailAndPasswordHash(String email, String passwordHash) {
        String sql = "SELECT id, nome, email, role " +
                "FROM utilizador " +
                "WHERE email = ? AND password = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, passwordHash);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setNome(rs.getString("nome"));
                    u.setEmail(rs.getString("email"));
                    u.setRole(rs.getString("role"));
                    return u;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean existsByEmail(String email) {
        String sql = "SELECT 1 FROM utilizador WHERE email = ? LIMIT 1";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void insertTutorUser(String nome, String email, String passwordHash) {
        String sql = "INSERT INTO utilizador (nome, email, password, role) VALUES (?, ?, ?, 'tutor')";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nome);
            ps.setString(2, email);
            ps.setString(3, passwordHash);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public List<User> findByRole(String role) {
        String sql = "SELECT id, nome, email, role FROM utilizador WHERE role = ? ORDER BY nome";
        List<User> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, role);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setNome(rs.getString("nome"));
                    u.setEmail(rs.getString("email"));
                    u.setRole(rs.getString("role"));
                    list.add(u);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Veterinario> findVeterinariosComLicenca() {
        String sql = """
        SELECT u.id, u.nome, u.email, v.numLicenca
        FROM utilizador u
        LEFT JOIN veterinario v ON v.email = u.email
        WHERE u.role = 'veterinario'
        ORDER BY u.nome
    """;

        List<Veterinario> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Veterinario v = new Veterinario();
                v.setId(rs.getInt("id"));
                v.setNome(rs.getString("nome"));
                v.setEmail(rs.getString("email"));
                v.setNumLicenca(rs.getString("numLicenca")); // pode ser null
                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


}
