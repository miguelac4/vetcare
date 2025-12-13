package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.Agendamento;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AgendamentoDao {

    public List<Agendamento> findAll() {
        String sql = "SELECT * FROM agendamento ORDER BY dataHora DESC";

        List<Agendamento> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Agendamento a = new Agendamento();
                a.setIdAgendamento(rs.getInt("idAgendamento"));

                Timestamp ts = rs.getTimestamp("dataHora");
                a.setDataHora(ts == null ? null : ts.toLocalDateTime());

                a.setEstado(rs.getString("estado"));
                a.setCriadoPor(rs.getString("criadoPor"));
                a.setLocalidade(rs.getString("localidade"));
                a.setIdServico(rs.getInt("idServico"));
                a.setIdAnimal(rs.getInt("idAnimal"));

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
