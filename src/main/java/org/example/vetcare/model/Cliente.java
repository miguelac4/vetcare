package org.example.vetcare.model;

public class Cliente {
    private String nif;
    private String nome;
    private String sexo;
    private String telefone;
    private String email;
    private String morada;
    private String freguesia;
    private String concelho;
    private Double capitalSocial;

    public Cliente() {}

    public Cliente(String nif, String nome, String sexo, String telefone, String email,
                   String morada, String freguesia, String concelho, Double capitalSocial) {
        this.nif = nif;
        this.nome = nome;
        this.sexo = sexo;
        this.telefone = telefone;
        this.email = email;
        this.morada = morada;
        this.freguesia = freguesia;
        this.concelho = concelho;
        this.capitalSocial = capitalSocial;
    }

    public String getNif() { return nif; }
    public void setNif(String nif) { this.nif = nif; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getSexo() { return sexo; }
    public void setSexo(String sexo) { this.sexo = sexo; }

    public String getTelefone() { return telefone; }
    public void setTelefone(String telefone) { this.telefone = telefone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMorada() { return morada; }
    public void setMorada(String morada) { this.morada = morada; }

    public String getFreguesia() { return freguesia; }
    public void setFreguesia(String freguesia) { this.freguesia = freguesia; }

    public String getConcelho() { return concelho; }
    public void setConcelho(String concelho) { this.concelho = concelho; }

    public Double getCapitalSocial() { return capitalSocial; }
    public void setCapitalSocial(Double capitalSocial) { this.capitalSocial = capitalSocial; }
}
