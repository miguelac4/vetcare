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

    public List<Animal> findAll() {
        String sql = "SELECT idAnimal, nome FROM animal ORDER BY nome";
        List<Animal> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Animal a = new Animal();
                a.setIdAnimal(rs.getInt("idAnimal"));
                a.setNome(rs.getString("nome"));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


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

    public Animal findById(int idAnimal) {
        String sql = "SELECT * FROM animal WHERE idAnimal = ?";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idAnimal);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Animal a = new Animal();
                    a.setIdAnimal(rs.getInt("idAnimal"));
                    a.setNome(rs.getString("nome"));
                    a.setRaca(rs.getString("raca"));
                    a.setSexo(rs.getString("sexo"));

                    java.sql.Date dn = rs.getDate("dataNascimento");
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

                    return a;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void update(Animal a) {
        String sql = """
        UPDATE animal SET
            nome = ?,
            raca = ?,
            sexo = ?,
            dataNascimento = ?,
            filiacao = ?,
            estadoReprodutivo = ?,
            alergia = ?,
            cor = ?,
            fotografia = ?,
            peso = ?,
            distintivas = ?,
            numChip = ?
        WHERE idAnimal = ?
        """;

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getNome());
            ps.setString(2, a.getRaca());
            ps.setString(3, a.getSexo());

            if (a.getDataNascimento() == null)
                ps.setNull(4, java.sql.Types.DATE);
            else
                ps.setDate(4, java.sql.Date.valueOf(a.getDataNascimento()));

            ps.setString(5, a.getFiliacao());
            ps.setString(6, a.getEstadoReprodutivo());
            ps.setString(7, a.getAlergia());
            ps.setString(8, a.getCor());

            ps.setString(9, a.getFotografia());

            if (a.getPeso() == null)
                ps.setNull(10, java.sql.Types.DOUBLE);
            else
                ps.setDouble(10, a.getPeso());

            ps.setString(11, a.getDistintivas());
            ps.setString(12, a.getNumChip());
            ps.setInt(13, a.getIdAnimal());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
