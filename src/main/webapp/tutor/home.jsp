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
    <title>Home Tutor</title>
</head>
<body>
<h2>Home - Tutor</h2>

<ul>
    <li><a href="<%= request.getContextPath() %>/animais">Os meus animais</a></li>

    <li><a href="<%= request.getContextPath() %>/tutor/marcacoes">Marcações</a></li>

    <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
</ul>
</body>
</html>
