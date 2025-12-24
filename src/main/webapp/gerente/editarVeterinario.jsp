<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.example.vetcare.model.Veterinario" %>
<%
  Veterinario v = (Veterinario) request.getAttribute("vet");
%>
<html><body>
<h2>Editar Veterinário</h2>

<form method="post" action="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios/editar">
  <input type="hidden" name="id" value="<%= v.getId() %>"/>

  Nome: <input name="nome" value="<%= v.getNome() %>" required/><br/>
  Email: <input name="email" value="<%= v.getEmail() %>" required/><br/>
  Nº Licença: <input value="<%= v.getNumLicenca() %>" readonly/><br/><br/>

  <button type="submit">Guardar</button>
</form>

<p><a href="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios">Voltar</a></p>
</body></html>
