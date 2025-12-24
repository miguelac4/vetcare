<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

<%
  Cliente cliente = (Cliente) request.getAttribute("cliente");
%>

<html>
<head>
  <title>Gerente - Editar Tutor</title>
</head>
<body>

<h2>Editar Tutor</h2>

<p>
  <a href="<%= request.getContextPath() %>/utilizadores/tutores">Voltar</a>
  | <a href="<%= request.getContextPath() %>/logout">Logout</a>
</p>

<hr/>

<form method="post" action="<%= request.getContextPath() %>/gerente/tutor/editar">
  <input type="hidden" name="nif" value="<%= cliente.getNif() %>" />

  <p>
    <label>NIF:</label>
    <input type="text" value="<%= cliente.getNif() %>" readonly />
  </p>

  <p>
    <label>Nome:</label>
    <input type="text" name="nome" value="<%= cliente.getNome() %>" required />
  </p>

  <p>
    <label>Sexo:</label>
    <input type="text" name="sexo" value="<%= cliente.getSexo() == null ? "" : cliente.getSexo() %>" />
  </p>

  <p>
    <label>Telefone:</label>
    <input type="text" name="telefone" value="<%= cliente.getTelefone() == null ? "" : cliente.getTelefone() %>" />
  </p>

  <p>
    <label>Email:</label>
    <input type="text" value="<%= cliente.getEmail() %>" readonly />
    <input type="hidden" name="email" value="<%= cliente.getEmail() %>" />
  </p>

  <p>
    <label>Morada:</label>
    <input type="text" name="morada" value="<%= cliente.getMorada() == null ? "" : cliente.getMorada() %>" />
  </p>

  <p>
    <label>Freguesia:</label>
    <input type="text" name="freguesia" value="<%= cliente.getFreguesia() == null ? "" : cliente.getFreguesia() %>" />
  </p>

  <p>
    <label>Concelho:</label>
    <input type="text" name="concelho" value="<%= cliente.getConcelho() == null ? "" : cliente.getConcelho() %>" />
  </p>

  <p>
    <label>Capital Social:</label>
    <input type="text" name="capitalSocial"
           value="<%= cliente.getCapitalSocial() == null ? "" : cliente.getCapitalSocial() %>" />
  </p>

  <button type="submit">Guardar</button>
</form>

</body>
</html>

