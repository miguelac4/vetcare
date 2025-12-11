package org.example.vetcare.model;

public class Animal {

    private int idAnimal;
    private String nome;
    private String raca;
    private String sexo;

    public Animal(int idAnimal, String nome, String raca, String sexo) {
        this.idAnimal = idAnimal;
        this.nome = nome;
        this.raca = raca;
        this.sexo = sexo;
    }

    public int getIdAnimal() {
        return idAnimal;
    }

    public String getNome() {
        return nome;
    }

    public String getRaca() {
        return raca;
    }

    public String getSexo() {
        return sexo;
    }
}
