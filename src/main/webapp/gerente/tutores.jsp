<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 4:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.Cliente" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Gerente - Tutores</title></head>
<body>

<h2>Lista de Tutores</h2>

<table border="1" cellpadding="6">
    <tr><th>NIF</th><th>Nome</th><th>Email</th></tr>

    <%
        List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
        if (clientes != null) {
            for (Cliente c : clientes) {
    %>
    <tr>
        <td><%= c.getNif() %></td>
        <td><%= c.getNome() %></td>
        <td><%= c.getEmail() %></td>
    </tr>
    <%
            }
        }
    %>
</table>

<p><a href="<%= request.getContextPath() %>/gerente/utilizadores">Voltar</a></p>
</body>
</html>
