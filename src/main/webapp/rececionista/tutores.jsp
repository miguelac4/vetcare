<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/12/2025
  Time: 7:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

<html>
<head>
  <title>Tutores</title>
</head>
<body>

<h2>Tutores</h2>

<a href="<%= request.getContextPath() %>/rececionista/home.jsp">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<%
  List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
  if (clientes == null || clientes.isEmpty()) {
%>
<p>Sem tutores para mostrar.</p>
<%
} else {
%>
<table border="1" cellpadding="6">
  <tr>
    <th>Nome</th>
    <th>Email</th>
    <th>Ficha Cliente</th>
    <th>Animais</th>
  </tr>

  <%
    for (Cliente c : clientes) {
  %>
  <tr>
    <td><%= c.getNome() %></td>
    <td><%= c.getEmail() == null ? "" : c.getEmail() %></td>

    <td>
      <a href="<%= request.getContextPath() %>/rececionista/ficha-cliente?nif=<%= c.getNif() %>">
        Ficha Cliente
      </a>
    </td>

    <td>
      <a href="<%= request.getContextPath() %>/rececionista/animais?nif=<%= c.getNif() %>">
        Animais
      </a>
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
