<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <title>VetCare — Rececionista</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <span class="logo">🐾 vetCare</span>

  <nav class="nav">
    <a href="#">Home</a>
    <a href="<%= request.getContextPath() %>/logout" class="nav-logout">Sair</a>
  </nav>
</header>

<main class="content">
  <section class="page-head">
    <div>
      <h1>Home — Rececionista</h1>
      <p class="muted">Gestão de clientes e agendamentos</p>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Ações rápidas</h2>
      <p class="muted">Acesso às principais funcionalidades</p>
    </div>

    <div class="actions">
      <a class="btn btn-primary"
        href="<%= request.getContextPath() %>/utilizadores/tutores">
          Tutores
      </a>

      <a class="btn btn-secondary"
       href="<%= request.getContextPath() %>/rececionista/agendamentos">
        Agendamentos
      </a>
    </div>
  </section>
</main>

<footer class="footer">
    © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
