package org.example.vetcare.dao;

import org.example.vetcare.config.DbConnection;
import org.example.vetcare.model.Taxonomia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TaxonomiaDao {

    public List<Taxonomia> findAll() {
        String sql = """
            SELECT
              idTaxonomia, especie, raca,
              regimeAlimentar, padraoAtividade, vocalizacao,
              expetativaVida, peso, comprimento, porte,
              predisposicaoGenetica, cuidadosEspeciais
            FROM taxonomia
            ORDER BY especie, raca
            """;

        List<Taxonomia> list = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Taxonomia t = new Taxonomia();
                t.setIdTaxonomia(rs.getInt("idTaxonomia"));

                t.setEspecie(rs.getString("especie"));
                t.setRaca(rs.getString("raca"));

                t.setRegimeAlimentar(rs.getString("regimeAlimentar"));
                t.setPadraoAtividade(rs.getString("padraoAtividade"));
                t.setVocalizacao(rs.getString("vocalizacao"));

                int ev = rs.getInt("expetativaVida");
                t.setExpetativaVida(rs.wasNull() ? null : ev);

                double p = rs.getDouble("peso");
                t.setPeso(rs.wasNull() ? null : p);

                double c = rs.getDouble("comprimento");
                t.setComprimento(rs.wasNull() ? null : c);

                t.setPorte(rs.getString("porte"));
                t.setPredisposicaoGenetica(rs.getString("predisposicaoGenetica"));
                t.setCuidadosEspeciais(rs.getString("cuidadosEspeciais"));

                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
