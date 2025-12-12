package org.example.vetcare.model;

import java.time.LocalDate;

public class Animal {

    private int idAnimal;
    private String nome;
    private String raca;
    private String sexo;

    private LocalDate dataNascimento;
    private String filiacao;
    private String estadoReprodutivo;
    private String alergia;
    private String cor;
    private String fotografia;
    private Double peso;
    private String distintivas;
    private String numChip;

    // FK / ligação ao tutor
    private String nif;

    public Animal() {}

    public Animal(int idAnimal, String nome, String raca, String sexo, LocalDate dataNascimento,
                  String filiacao, String estadoReprodutivo, String alergia, String cor,
                  String fotografia, Double peso, String distintivas, String numChip, String nif) {
        this.idAnimal = idAnimal;
        this.nome = nome;
        this.raca = raca;
        this.sexo = sexo;
        this.dataNascimento = dataNascimento;
        this.filiacao = filiacao;
        this.estadoReprodutivo = estadoReprodutivo;
        this.alergia = alergia;
        this.cor = cor;
        this.fotografia = fotografia;
        this.peso = peso;
        this.distintivas = distintivas;
        this.numChip = numChip;
        this.nif = nif;
    }

    public int getIdAnimal() { return idAnimal; }
    public void setIdAnimal(int idAnimal) { this.idAnimal = idAnimal; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getRaca() { return raca; }
    public void setRaca(String raca) { this.raca = raca; }

    public String getSexo() { return sexo; }
    public void setSexo(String sexo) { this.sexo = sexo; }

    public LocalDate getDataNascimento() { return dataNascimento; }
    public void setDataNascimento(LocalDate dataNascimento) { this.dataNascimento = dataNascimento; }

    public String getFiliacao() { return filiacao; }
    public void setFiliacao(String filiacao) { this.filiacao = filiacao; }

    public String getEstadoReprodutivo() { return estadoReprodutivo; }
    public void setEstadoReprodutivo(String estadoReprodutivo) { this.estadoReprodutivo = estadoReprodutivo; }

    public String getAlergia() { return alergia; }
    public void setAlergia(String alergia) { this.alergia = alergia; }

    public String getCor() { return cor; }
    public void setCor(String cor) { this.cor = cor; }

    public String getFotografia() { return fotografia; }
    public void setFotografia(String fotografia) { this.fotografia = fotografia; }

    public Double getPeso() { return peso; }
    public void setPeso(Double peso) { this.peso = peso; }

    public String getDistintivas() { return distintivas; }
    public void setDistintivas(String distintivas) { this.distintivas = distintivas; }

    public String getNumChip() { return numChip; }
    public void setNumChip(String numChip) { this.numChip = numChip; }

    public String getNif() { return nif; }
    public void setNif(String nif) { this.nif = nif; }
}
