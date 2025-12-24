<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/12/2025
  Time: 3:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Gerente</title>
</head>
<body>
Home - Gerente

<li>
    <a href="<%= request.getContextPath() %>/gerente/utilizadores">Utilizadores</a>
</li>

<li>
    <a href="<%= request.getContextPath() %>/gerente/animais">Animais</a>
</li>

<li>
    <a href="<%= request.getContextPath() %>/logout">Logout</a>
</li>

</body>
</html>
