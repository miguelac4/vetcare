<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 6:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.Veterinario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Gerente - Veterinários</title>
</head>
<body>

<h2>Veterinários</h2>

<table border="1" cellpadding="6">
  <tr>
    <th>ID</th>
    <th>Nome</th>
    <th>Email</th>
    <th>Nº Licença</th>
    <th>Ações</th>
  </tr>

  <%
    List<Veterinario> veterinarios = (List<Veterinario>) request.getAttribute("veterinarios");
    if (veterinarios != null) {
      for (Veterinario v : veterinarios) {
  %>
  <tr>
    <td><%= v.getId() %></td>
    <td><%= v.getNome() %></td>
    <td><%= v.getEmail() %></td>
    <td><%= v.getNumLicenca() == null ? "(sem registo)" : v.getNumLicenca() %></td>
    <td>
      <a href="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios/editar?id=<%= v.getId() %>">Editar</a>
    </td>

  </tr>
  <%
      }
    }
  %>
</table>

<p>
  <a href="<%= request.getContextPath() %>/gerente/utilizadores">Voltar</a>
</p>

</body>
</html>
