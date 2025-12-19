<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/12/2025
  Time: 8:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Animal" %>

<html>
<head>
  <title>Animais do Tutor</title>
</head>
<body>

<h2>Animais do Tutor</h2>

<a href="<%= request.getContextPath() %>/rececionista/tutores">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<%
  String nif = (String) request.getAttribute("nif");
  List<Animal> animais = (List<Animal>) request.getAttribute("animais");
%>

<p><b>NIF:</b> <%= nif == null ? "" : nif %></p>

<p>
  <a href="<%= request.getContextPath() %>/rececionista/animal/novo?nif=<%= nif %>">
    Adicionar Animal
  </a>
</p>

<%
  if (animais == null || animais.isEmpty()) {
%>
<p>Este tutor não tem animais registados.</p>
<%
} else {
%>
<table border="1" cellpadding="6">
  <tr>
    <th>ID</th>
    <th>Nome</th>
    <th>Raça</th>
    <th>Sexo</th>
    <th>Data Nascimento</th>
    <th>Estado Reprodutivo</th>
    <th>Alergia</th>
    <th>Cor</th>
    <th>Peso</th>
    <th>Distintivas</th>
    <th>Nº Chip</th>
    <th>Fotografia</th>
  </tr>

  <%
    for (Animal a : animais) {
  %>
  <tr>
    <td><%= a.getIdAnimal() %></td>
    <td><%= a.getNome() %></td>
    <td><%= a.getRaca() == null ? "" : a.getRaca() %></td>
    <td><%= a.getSexo() == null ? "" : a.getSexo() %></td>
    <td><%= a.getDataNascimento() == null ? "" : a.getDataNascimento() %></td>
    <td><%= a.getEstadoReprodutivo() == null ? "" : a.getEstadoReprodutivo() %></td>
    <td><%= a.getAlergia() == null ? "" : a.getAlergia() %></td>
    <td><%= a.getCor() == null ? "" : a.getCor() %></td>
    <td><%= a.getPeso() == null ? "" : a.getPeso() %></td>
    <td><%= a.getDistintivas() == null ? "" : a.getDistintivas() %></td>
    <td><%= a.getNumChip() == null ? "" : a.getNumChip() %></td>
    <td>
      <%
        String foto = a.getFotografia();
        if (foto != null && !foto.isBlank()) {
      %>
      <a href="<%= request.getContextPath() + foto %>" target="_blank">Ver</a>
      <!-- <br/><img src="<%= request.getContextPath() + foto %>" width="80" /> -->
      <%
      } else {
      %>
      -
      <%
        }
      %>
    </td>

    <td>
      <a href="<%= request.getContextPath() %>/rececionista/animal/editar?id=<%= a.getIdAnimal() %>">Editar</a>
    </td>

  </tr>
  <%
    }
  %>
</table>
<%
  }
%>

</body>
</html>