<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 9:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Animal" %>
<%@ page import="org.example.vetcare.model.Taxonomia" %>

<%
  Animal a = (Animal) request.getAttribute("animal");
  if (a == null) {
%>
<h2>Animal não encontrado.</h2>
<a href="<%= request.getContextPath() %>/rececionista/tutores">Voltar</a>
<%
    return;
  }

  // dropdowns vindos do servlet
  List<Animal> animaisDoTutor = (List<Animal>) request.getAttribute("animaisDoTutor");
  List<Taxonomia> taxonomias = (List<Taxonomia>) request.getAttribute("taxonomias");

  // Para preencher o input type="date" precisamos de YYYY-MM-DD.
  String dataNasc = (a.getDataNascimento() == null) ? "" : a.getDataNascimento().toString();
%>

<html>
<head>
  <title>Editar Animal</title>
</head>
<body>

<h2>Editar Animal</h2>

<a href="<%= request.getContextPath() %>/animais?nif=<%= a.getNif() %>">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<%
  String erro = (String) request.getAttribute("erro");
  if (erro != null) {
%>
<p style="color:red;"><%= erro %></p>
<%
  }
%>

<form method="post" action="<%= request.getContextPath() %>/rececionista/animal/editar" enctype="multipart/form-data">

  <!-- chaves/ids -->
  <input type="hidden" name="idAnimal" value="<%= a.getIdAnimal() %>"/>
  <input type="hidden" name="nif" value="<%= a.getNif() %>"/>

  Nome:
  <input type="text" name="nome" value="<%= a.getNome() == null ? "" : a.getNome() %>" maxlength="20" required />
  <br/><br/>

  Raça:
  <input type="text" name="raca" value="<%= a.getRaca() == null ? "" : a.getRaca() %>" maxlength="20" />
  <br/><br/>

  Sexo:
  <select name="sexo" required>
    <option value="">-- selecionar --</option>
    <option value="M" <%= "M".equals(a.getSexo()) ? "selected" : "" %>>M</option>
    <option value="F" <%= "F".equals(a.getSexo()) ? "selected" : "" %>>F</option>
  </select>
  <br/><br/>

  Data de Nascimento:
  <input type="date" name="dataNascimento" value="<%= dataNasc %>" />
  <br/><br/>

  <!-- NOVO: Pai -->
  Pai:
  <select name="idPai">
    <option value="">-- (desconhecido) --</option>
    <%
      if (animaisDoTutor != null) {
        for (Animal p : animaisDoTutor) {
          // opcional: filtrar apenas machos
          if (p.getSexo() != null && !"M".equalsIgnoreCase(p.getSexo())) continue;

          // evitar o próprio animal como pai
          if (p.getIdAnimal() == a.getIdAnimal()) continue;

          String sel = (a.getIdPai() != null && a.getIdPai().intValue() == p.getIdAnimal()) ? "selected" : "";
    %>
    <option value="<%= p.getIdAnimal() %>" <%= sel %>><%= p.getNome() %> (#<%= p.getIdAnimal() %>)</option>
    <%
        }
      }
    %>
  </select>
  <br/><br/>

  <!-- NOVO: Mãe -->
  Mãe:
  <select name="idMae">
    <option value="">-- (desconhecida) --</option>
    <%
      if (animaisDoTutor != null) {
        for (Animal m : animaisDoTutor) {
          // opcional: filtrar apenas fêmeas
          if (m.getSexo() != null && !"F".equalsIgnoreCase(m.getSexo())) continue;

          // evitar o próprio animal como mãe
          if (m.getIdAnimal() == a.getIdAnimal()) continue;

          String sel = (a.getIdMae() != null && a.getIdMae().intValue() == m.getIdAnimal()) ? "selected" : "";
    %>
    <option value="<%= m.getIdAnimal() %>" <%= sel %>><%= m.getNome() %> (#<%= m.getIdAnimal() %>)</option>
    <%
        }
      }
    %>
  </select>
  <br/><br/>

  <!-- NOVO: Taxonomia -->
  Taxonomia:
  <select name="idTaxonomia" required>
    <option value="">-- escolher --</option>
    <%
      if (taxonomias != null) {
        for (Taxonomia t : taxonomias) {

          String especie = t.getEspecie() == null ? "" : t.getEspecie();
          String racaTx = t.getRaca() == null ? "" : t.getRaca();

          String labelBase = especie + (racaTx.isBlank() ? "" : " - " + racaTx);

          String detalhes =
                  " | " + (t.getPorte() == null ? "-" : t.getPorte()) +
                          " | " + (t.getRegimeAlimentar() == null ? "-" : t.getRegimeAlimentar()) +
                          " | vida: " + (t.getExpetativaVida() == null ? "-" : t.getExpetativaVida()) + " anos" +
                          " | peso: " + (t.getPeso() == null ? "-" : String.format(java.util.Locale.US, "%.2f", t.getPeso())) + " kg" +
                          " | comp: " + (t.getComprimento() == null ? "-" : String.format(java.util.Locale.US, "%.2f", t.getComprimento())) + " cm";

          String extra = "";
          if (t.getPredisposicaoGenetica() != null && !t.getPredisposicaoGenetica().isBlank()) {
            extra += " | gen: " + t.getPredisposicaoGenetica();
          }
          if (t.getCuidadosEspeciais() != null && !t.getCuidadosEspeciais().isBlank()) {
            extra += " | cuidados: " + t.getCuidadosEspeciais();
          }

          String sel = (a.getIdTaxonomia() != null && a.getIdTaxonomia().intValue() == t.getIdTaxonomia()) ? "selected" : "";
    %>
    <option value="<%= t.getIdTaxonomia() %>" <%= sel %>><%= labelBase + detalhes + extra %></option>
    <%
        }
      }
    %>
  </select>
  <br/><br/>

  Estado Reprodutivo:
  <input type="text" name="estadoReprodutivo" value="<%= a.getEstadoReprodutivo() == null ? "" : a.getEstadoReprodutivo() %>" maxlength="12" />
  <br/><br/>

  Alergia:
  <input type="text" name="alergia" value="<%= a.getAlergia() == null ? "" : a.getAlergia() %>" maxlength="20" />
  <br/><br/>

  Cor:
  <input type="text" name="cor" value="<%= a.getCor() == null ? "" : a.getCor() %>" maxlength="15" />
  <br/><br/>

  Peso:
  <input type="number" step="0.01" name="peso" value="<%= a.getPeso() == null ? "" : a.getPeso() %>" />
  <br/><br/>

  Distintivas:
  <input type="text" name="distintivas" value="<%= a.getDistintivas() == null ? "" : a.getDistintivas() %>" maxlength="30" />
  <br/><br/>

  Nº Chip:
  <input type="text" name="numChip" value="<%= a.getNumChip() == null ? "" : a.getNumChip() %>" maxlength="15" />
  <br/><br/>

  Fotografia:
  <input type="file" name="fotografia" accept="image/*" />
  <br/><br/>

  <button type="submit">Guardar</button>
</form>

</body>
</html>