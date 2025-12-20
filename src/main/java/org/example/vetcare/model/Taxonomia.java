package org.example.vetcare.model;

public class Taxonomia {

    private int idTaxonomia;

    private String especie;
    private String raca;

    private String regimeAlimentar;
    private String padraoAtividade;
    private String vocalizacao;

    private Integer expetativaVida;
    private Double peso;
    private Double comprimento;
    private String porte;

    private String predisposicaoGenetica;
    private String cuidadosEspeciais;

    public int getIdTaxonomia() { return idTaxonomia; }
    public void setIdTaxonomia(int idTaxonomia) { this.idTaxonomia = idTaxonomia; }

    public String getEspecie() { return especie; }
    public void setEspecie(String especie) { this.especie = especie; }

    public String getRaca() { return raca; }
    public void setRaca(String raca) { this.raca = raca; }

    public String getRegimeAlimentar() { return regimeAlimentar; }
    public void setRegimeAlimentar(String regimeAlimentar) { this.regimeAlimentar = regimeAlimentar; }

    public String getPadraoAtividade() { return padraoAtividade; }
    public void setPadraoAtividade(String padraoAtividade) { this.padraoAtividade = padraoAtividade; }

    public String getVocalizacao() { return vocalizacao; }
    public void setVocalizacao(String vocalizacao) { this.vocalizacao = vocalizacao; }

    public Integer getExpetativaVida() { return expetativaVida; }
    public void setExpetativaVida(Integer expetativaVida) { this.expetativaVida = expetativaVida; }

    public Double getPeso() { return peso; }
    public void setPeso(Double peso) { this.peso = peso; }

    public Double getComprimento() { return comprimento; }
    public void setComprimento(Double comprimento) { this.comprimento = comprimento; }

    public String getPorte() { return porte; }
    public void setPorte(String porte) { this.porte = porte; }

    public String getPredisposicaoGenetica() { return predisposicaoGenetica; }
    public void setPredisposicaoGenetica(String predisposicaoGenetica) { this.predisposicaoGenetica = predisposicaoGenetica; }

    public String getCuidadosEspeciais() { return cuidadosEspeciais; }
    public void setCuidadosEspeciais(String cuidadosEspeciais) { this.cuidadosEspeciais = cuidadosEspeciais; }
}
