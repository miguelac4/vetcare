package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.HistoricoClinico;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoricoClinicoDao {

    public List<HistoricoClinico> findByAnimal(int idAnimal) {
        String sql = """
        SELECT h.idHistorico, h.idAnimal, h.numLicenca, h.descricao, h.criadoEm,
               v.nome AS nomeVeterinario
        FROM historico_clinico h
        JOIN veterinario v ON v.numLicenca = h.numLicenca
        WHERE h.idAnimal = ?
        ORDER BY h.criadoEm DESC
        """;

        List<HistoricoClinico> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idAnimal);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    HistoricoClinico h = new HistoricoClinico();
                    h.setIdHistorico(rs.getInt("idHistorico"));
                    h.setIdAnimal(rs.getInt("idAnimal"));
                    h.setNumLicenca(rs.getString("numLicenca"));
                    h.setDescricao(rs.getString("descricao"));

                    Timestamp ts = rs.getTimestamp("criadoEm");
                    h.setCriadoEm(ts == null ? null : ts.toLocalDateTime());

                    h.setNomeVeterinario(rs.getString("nomeVeterinario"));
                    list.add(h);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int insert(int idAnimal, String numLicenca, String descricao) {
        String sql = "INSERT INTO historico_clinico (idAnimal, numLicenca, descricao) VALUES (?, ?, ?)";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idAnimal);
            ps.setString(2, numLicenca);
            ps.setString(3, descricao);

            return ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
