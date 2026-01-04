<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>vetCare — Início</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/index.jsp">🐾 vetCare</a>
</header>

<main class="content">
  <section class="panel" style="max-width: 640px; margin: 56px auto;">
    <div class="panel-head">
      <h1>VetCare</h1>
      <p class="muted">Acede à tua conta ou cria uma conta de Tutor.</p>
    </div>

    <div class="actions" style="margin-top: 12px;">
      <a class="btn btn-primary" href="<%= request.getContextPath() %>/login">Login</a>
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/register">Criar uma conta</a>
    </div>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
