<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 11/29/2025
  Time: 11:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare Clinic</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">

<main class="content">
  <section class="panel" style="max-width: 680px; margin: 40px auto;">
    <div class="panel-head">
      <h1>VetCare Clinic</h1>
      <p>Aceda à sua conta ou crie uma nova conta.</p>
    </div>

    <div class="actions">
        <a class="btn btn-primary" href="<%= request.getContextPath() %>/login">Login</a>
        <a class="btn btn-secondary" href="<%= request.getContextPath() %>/register">Criar uma Conta</a>
    </div>
  </section>
</main>

<footer class="footer">
  @ 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
