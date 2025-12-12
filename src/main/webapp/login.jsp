<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/12/2025
  Time: 2:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>vetCare - Login</title>
</head>
<body>
<h2>Login</h2>

<%
  String erro = (String) request.getAttribute("erro");
  if (erro != null) {
%>
<p style="color:red;"><%= erro %></p>
<%
  }
%>

<form method="post" action="<%= request.getContextPath() %>/login">
  <label>Email:</label><br/>
  <input type="email" name="email" required /><br/><br/>

  <label>Password:</label><br/>
  <input type="password" name="password" required /><br/><br/>

  <button type="submit">Entrar</button>
</form>
</body>
</html>

