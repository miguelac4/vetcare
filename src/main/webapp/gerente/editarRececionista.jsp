<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.example.vetcare.model.User" %>
<%
  User u = (User) request.getAttribute("user");
%>
<html><body>
<h2>Editar Rececionista</h2>

<form method="post" action="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas/editar">
  <input type="hidden" name="id" value="<%= u.getId() %>"/>

  Nome: <input name="nome" value="<%= u.getNome() %>" required/><br/>
  Email: <input name="email" value="<%= u.getEmail() %>" required/><br/><br/>

  <button type="submit">Guardar</button>
</form>

<p><a href="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas">Voltar</a></p>
</body></html>
