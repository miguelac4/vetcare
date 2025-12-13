<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 9:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

<%
  Cliente c = (Cliente) request.getAttribute("cliente");
%>

<html>
<head>
  <title>Editar Tutor</title>
</head>
<body>

<h2>Editar Tutor</h2>

<form method="post" action="<%= request.getContextPath() %>/rececionista/tutor/editar">
  <input type="hidden" name="nif" value="<%= c.getNif() %>"/>

  Nome: <input type="text" name="nome" value="<%= c.getNome() %>" /><br/>
  Sexo:
  <select name="sexo">
    <option value="">-- selecionar --</option>
    <option value="M" <%= "M".equals(c.getSexo()) ? "selected" : "" %>>M</option>
    <option value="F" <%= "F".equals(c.getSexo()) ? "selected" : "" %>>F</option>
  </select>
  <br/>
  Telefone: <input type="text" name="telefone" value="<%= c.getTelefone() %>" /><br/>
  Email: <input type="email" name="email" value="<%= c.getEmail() %>" /><br/>
  Morada: <input type="text" name="morada" value="<%= c.getMorada() %>" /><br/>
  Freguesia: <input type="text" name="freguesia" value="<%= c.getFreguesia() %>" /><br/>
  Concelho: <input type="text" name="concelho" value="<%= c.getConcelho() %>" /><br/>
  Capital Social: <input type="number" step="0.01" name="capitalSocial"
                         value="<%= c.getCapitalSocial() == null ? "" : c.getCapitalSocial() %>" /><br/><br/>

  <button type="submit">Guardar</button>
</form>

</body>
</html>
