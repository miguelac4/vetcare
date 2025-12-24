package org.example.vetcare.model;

public class Veterinario {
    private int id;
    private String nome;
    private String email;
    private String numLicenca; // "V1001"

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNumLicenca() { return numLicenca; }
    public void setNumLicenca(String numLicenca) { this.numLicenca = numLicenca; }
}
