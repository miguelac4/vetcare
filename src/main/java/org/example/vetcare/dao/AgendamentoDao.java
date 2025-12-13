package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.Agendamento;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AgendamentoDao {

    public List<Agendamento> findAll() {
        String sql =
                "SELECT ag.*, an.nome AS nomeAnimal, sv.tipo AS tipoServico " +
                        "FROM agendamento ag " +
                        "JOIN animal an ON an.idAnimal = ag.idAnimal " +
                        "JOIN servico sv ON sv.idServico = ag.idServico " +
                        "ORDER BY ag.dataHora DESC";

        List<Agendamento> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Agendamento a = new Agendamento();

                a.setIdAgendamento(rs.getInt("idAgendamento"));

                java.sql.Timestamp ts = rs.getTimestamp("dataHora");
                a.setDataHora(ts == null ? null : ts.toLocalDateTime());

                a.setEstado(rs.getString("estado"));
                a.setCriadoPor(rs.getString("criadoPor"));
                a.setLocalidade(rs.getString("localidade"));
                a.setIdServico(rs.getInt("idServico"));
                a.setIdAnimal(rs.getInt("idAnimal"));

                a.setNomeAnimal(rs.getString("nomeAnimal"));
                a.setTipoServico(rs.getString("tipoServico"));

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateEstado(int idAgendamento, String estado) {
        String sql = "UPDATE agendamento SET estado = ? WHERE idAgendamento = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, estado);
            ps.setInt(2, idAgendamento);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Agendamento findById(int id) {
        String sql = "SELECT * FROM agendamento WHERE idAgendamento = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Agendamento a = new Agendamento();
                    a.setIdAgendamento(rs.getInt("idAgendamento"));

                    java.sql.Timestamp ts = rs.getTimestamp("dataHora");
                    a.setDataHora(ts == null ? null : ts.toLocalDateTime());

                    a.setEstado(rs.getString("estado"));
                    a.setCriadoPor(rs.getString("criadoPor"));
                    a.setLocalidade(rs.getString("localidade"));
                    a.setIdServico(rs.getInt("idServico"));
                    a.setIdAnimal(rs.getInt("idAnimal"));
                    return a;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int reagendar(int idAgendamento, java.time.LocalDateTime novaDataHora, String novaLocalidade, int novoIdServico) {
        String sql = "UPDATE agendamento SET dataHora = ?, localidade = ?, idServico = ?, estado = 'reagendado' " +
                "WHERE idAgendamento = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(novaDataHora));
            ps.setString(2, novaLocalidade);
            ps.setInt(3, novoIdServico);
            ps.setInt(4, idAgendamento);

            int rows = ps.executeUpdate();
            System.out.println("reagendar() rows updated = " + rows + " for idAgendamento=" + idAgendamento);
            return rows;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }






}
