<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 9:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Animal" %>

<%
  Animal a = (Animal) request.getAttribute("animal");
  if (a == null) {
%>
<h2>Animal não encontrado.</h2>
<a href="<%= request.getContextPath() %>/rececionista/tutores">Voltar</a>
<%
    return;
  }

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

  Filiação:
  <input type="text" name="filiacao" value="<%= a.getFiliacao() == null ? "" : a.getFiliacao() %>" maxlength="10" />
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
