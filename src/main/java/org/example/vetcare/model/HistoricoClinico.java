package org.example.vetcare.model;

import java.time.LocalDateTime;

public class HistoricoClinico {
    private int idHistorico;
    private int idAnimal;
    private String numLicenca;
    private String descricao;
    private LocalDateTime criadoEm;

    private String nomeVeterinario;

    public int getIdHistorico() { return idHistorico; }
    public void setIdHistorico(int idHistorico) { this.idHistorico = idHistorico; }

    public int getIdAnimal() { return idAnimal; }
    public void setIdAnimal(int idAnimal) { this.idAnimal = idAnimal; }

    public String getNumLicenca() { return numLicenca; }
    public void setNumLicenca(String numLicenca) { this.numLicenca = numLicenca; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public LocalDateTime getCriadoEm() { return criadoEm; }
    public void setCriadoEm(LocalDateTime criadoEm) { this.criadoEm = criadoEm; }

    public String getNomeVeterinario() { return nomeVeterinario; }
    public void setNomeVeterinario(String nomeVeterinario) { this.nomeVeterinario = nomeVeterinario; }
}
