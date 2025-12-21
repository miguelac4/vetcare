<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/21/2025
  Time: 1:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Animal" %>

<%
  Animal animal = (Animal) request.getAttribute("animal");
  Animal pai = (Animal) request.getAttribute("pai");
  Animal mae = (Animal) request.getAttribute("mae");

  Animal avoPaterno = (Animal) request.getAttribute("avoPaterno");
  Animal avoPaterna = (Animal) request.getAttribute("avoPaterna");
  Animal avoMaterno = (Animal) request.getAttribute("avoMaterno");
  Animal avoMaterna = (Animal) request.getAttribute("avoMaterna");

  String ctx = request.getContextPath();

  if (animal == null) {
%>
<h2>Animal não encontrado.</h2>
<a href="javascript:history.back()">Voltar</a>
<%
    return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Árvore Genealógica</title>
</head>
<body>

<h2>Árvore Genealógica</h2>

<%
  String nif = (String) request.getAttribute("nif");
  String backClinico = ctx + "/veterinario/animal/registro-clinico?id=" + animal.getIdAnimal()
          + (nif != null && !nif.isBlank() ? "&nif=" + nif : "");
%>

<a href="<%= backClinico %>">Voltar ao registo clínico</a>


<a href="<%= ctx %>/logout">Logout</a>

<hr/>

<table border="1" cellpadding="10" cellspacing="0">
  <tr>
    <th>Avós</th>
    <th>Pais</th>
    <th>Animal</th>
  </tr>

  <tr>
    <td>
      <b>Avô paterno:</b>
      <%
        if (avoPaterno != null) {
      %>
      <a href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoPaterno.getIdAnimal() %>">
        <%= avoPaterno.getNome() %> (#<%= avoPaterno.getIdAnimal() %>)
      </a>
      <%
        } else { out.print("-"); }
      %>
      <br/>

      <b>Avó paterna:</b>
      <%
        if (avoPaterna != null) {
      %>
      <a href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoPaterna.getIdAnimal() %>">
        <%= avoPaterna.getNome() %> (#<%= avoPaterna.getIdAnimal() %>)
      </a>
      <%
        } else { out.print("-"); }
      %>
      <br/><br/>

      <b>Avô materno:</b>
      <%
        if (avoMaterno != null) {
      %>
      <a href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoMaterno.getIdAnimal() %>">
        <%= avoMaterno.getNome() %> (#<%= avoMaterno.getIdAnimal() %>)
      </a>
      <%
        } else { out.print("-"); }
      %>
      <br/>

      <b>Avó materna:</b>
      <%
        if (avoMaterna != null) {
      %>
      <a href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoMaterna.getIdAnimal() %>">
        <%= avoMaterna.getNome() %> (#<%= avoMaterna.getIdAnimal() %>)
      </a>
      <%
        } else { out.print("-"); }
      %>
    </td>

    <td>
      <b>Pai:</b>
      <%
        if (pai != null) {
      %>
      <a href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= pai.getIdAnimal() %>">
        <%= pai.getNome() %> (#<%= pai.getIdAnimal() %>)
      </a>
      <%
        } else { out.print("-"); }
      %>
      <br/>

      <b>Mãe:</b>
      <%
        if (mae != null) {
      %>
      <a href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= mae.getIdAnimal() %>">
        <%= mae.getNome() %> (#<%= mae.getIdAnimal() %>)
      </a>
      <%
        } else { out.print("-"); }
      %>
    </td>

    <td>
      <b><%= animal.getNome() %></b> (#<%= animal.getIdAnimal() %>)
    </td>
  </tr>
</table>

</body>
</html>
