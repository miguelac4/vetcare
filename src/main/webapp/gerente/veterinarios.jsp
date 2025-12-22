<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 6:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.User" %>
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
  </tr>

  <%
    List<User> veterinarios = (List<User>) request.getAttribute("veterinarios");
    if (veterinarios != null) {
      for (User u : veterinarios) {
  %>
  <tr>
    <td><%= u.getId() %></td>
    <td><%= u.getNome() %></td>
    <td><%= u.getEmail() %></td>
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
