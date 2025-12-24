<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 3:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.Animal" %>

<%
  List<Animal> animais = (List<Animal>) request.getAttribute("animais");
%>

<html>
<head>
  <title>Gerente - Animais</title>
</head>
<body>

<h2>Lista de Animais</h2>

<p>
  <a href="<%= request.getContextPath() %>/gerente/home.jsp">Voltar</a>
  | <a href="<%= request.getContextPath() %>/logout">Logout</a>
</p>

<hr/>

<% if (animais == null || animais.isEmpty()) { %>
<p>Não existem animais registados.</p>
<% } else { %>
<table border="1" cellpadding="6">
  <tr>
    <th>ID</th>
    <th>Nome</th>
    <th>Ações</th>
  </tr>

  <% for (Animal a : animais) { %>
  <tr>
    <td><%= a.getIdAnimal() %></td>
    <td><%= a.getNome() %></td>
    <td>
      <a href="<%= request.getContextPath() %>/gerente/animais/exportar-json?idAnimal=<%= a.getIdAnimal() %>">
        Exportar JSON
      </a>
    </td>
  </tr>
  <% } %>
</table>
<% } %>

</body>
</html>

