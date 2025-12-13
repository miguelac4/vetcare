<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/12/2025
  Time: 8:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

<html>
<head>
  <title>Ficha do Cliente</title>
</head>
<body>

<h2>Ficha do Cliente</h2>

<a href="<%= request.getContextPath() %>/rececionista/tutores">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<%
  Cliente c = (Cliente) request.getAttribute("cliente");
  if (c == null) {
%>
<p>Cliente não encontrado.</p>
<%
} else {
%>

<table border="1" cellpadding="6">
  <tr><th>NIF</th><td><%= c.getNif() %></td></tr>
  <tr><th>Nome</th><td><%= c.getNome() %></td></tr>
  <tr><th>Sexo</th><td><%= c.getSexo() == null ? "" : c.getSexo() %></td></tr>
  <tr><th>Telefone</th><td><%= c.getTelefone() == null ? "" : c.getTelefone() %></td></tr>
  <tr><th>Email</th><td><%= c.getEmail() == null ? "" : c.getEmail() %></td></tr>
  <tr><th>Morada</th><td><%= c.getMorada() == null ? "" : c.getMorada() %></td></tr>
  <tr><th>Freguesia</th><td><%= c.getFreguesia() == null ? "" : c.getFreguesia() %></td></tr>
  <tr><th>Concelho</th><td><%= c.getConcelho() == null ? "" : c.getConcelho() %></td></tr>
  <tr><th>Capital Social</th>
    <td><%= c.getCapitalSocial() == null ? "" : c.getCapitalSocial() %></td>
  </tr>
</table>

<hr/>

<a href="<%= request.getContextPath() %>/rececionista/tutor/editar?nif=<%= c.getNif() %>">Editar Tutor</a>


<a href="<%= request.getContextPath() %>/rececionista/animais?nif=<%= c.getNif() %>">Ver Animais</a>

<%
  }
%>


</body>
</html>

