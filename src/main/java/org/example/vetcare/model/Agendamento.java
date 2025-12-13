package org.example.vetcare.model;

import java.time.LocalDateTime;

public class Agendamento {
    private int idAgendamento;
    private LocalDateTime dataHora;
    private String estado;
    private String criadoPor;
    private String localidade;
    private int idServico;
    private int idAnimal;

    private String nomeAnimal;
    private String tipoServico;

    public Agendamento() {}

    public int getIdAgendamento() { return idAgendamento; }
    public void setIdAgendamento(int idAgendamento) { this.idAgendamento = idAgendamento; }

    public LocalDateTime getDataHora() { return dataHora; }
    public void setDataHora(LocalDateTime dataHora) { this.dataHora = dataHora; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getCriadoPor() { return criadoPor; }
    public void setCriadoPor(String criadoPor) { this.criadoPor = criadoPor; }

    public String getLocalidade() { return localidade; }
    public void setLocalidade(String localidade) { this.localidade = localidade; }

    public int getIdServico() { return idServico; }
    public void setIdServico(int idServico) { this.idServico = idServico; }

    public int getIdAnimal() { return idAnimal; }
    public void setIdAnimal(int idAnimal) { this.idAnimal = idAnimal; }

    // Joins nos nomes do animal e serviço, para a listagem
    public String getNomeAnimal() { return nomeAnimal; }
    public void setNomeAnimal(String nomeAnimal) { this.nomeAnimal = nomeAnimal; }

    public String getTipoServico() { return tipoServico; }
    public void setTipoServico(String tipoServico) { this.tipoServico = tipoServico; }
}
