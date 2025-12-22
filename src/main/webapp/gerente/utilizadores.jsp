<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 3:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gerente - Utilizadores</title>
</head>
<body>

<h2>Gerente - Utilizadores</h2>

<p>
    <a href="<%= request.getContextPath() %>/utilizadores/tutores">Clientes (Tutores)</a>
</p>

<p>
    <a href="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios">Veterinários</a>
</p>

<p>
    <a href="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas">Rececionistas</a>
</p>

<p>
    <a href="<%= request.getContextPath() %>/gerente/home.jsp">Voltar</a>
</p>

</body>
</html>

