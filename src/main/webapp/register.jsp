<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/19/2025
  Time: 6:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>VetCare - Registo</title>
</head>
<body>

<h2>Criar Conta (Tutor)</h2>

<%
  String erro = (String) request.getAttribute("erro");
  if (erro != null) {
%>
<p style="color:red;"><%= erro %></p>
<%
  }
%>

<form method="post" action="<%= request.getContextPath() %>/register">
  <label>Nome:</label><br/>
  <input type="text" name="nome" required /><br/><br/>

  <label>NIF:</label><br/>
  <input type="text" name="nif" required /><br/><br/>

  <label>Email:</label><br/>
  <input type="email" name="email" required /><br/><br/>

  <label>Password:</label><br/>
  <input type="password" name="password" required /><br/><br/>

  <label>Telefone (opcional):</label><br/>
  <input type="text" name="telefone" /><br/><br/>

  <label>Morada (opcional):</label><br/>
  <input type="text" name="morada" /><br/><br/>

  <button type="submit">Registar</button>
</form>

<p>
  Já tens conta?
  <a href="<%= request.getContextPath() %>/login">Login</a>
</p>

</body>
</html>

