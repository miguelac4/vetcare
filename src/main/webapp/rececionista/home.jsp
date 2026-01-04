<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String nome = (String) session.getAttribute("userNome");
  String role = (String) session.getAttribute("userRole");

  String roleLabel = "Rececionista";
%>

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
  <a class="logo" href="<%= request.getContextPath() %>/rececionista/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/rececionista/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/utilizadores/tutores">Tutores</a>
    <a href="<%= request.getContextPath() %>/rececionista/agendamentos">Agendamentos</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>

  <!-- badge do role -->
  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>
</header>

<main class="content">

  <section class="page-head">
    <div>
      <h1>Área da Rececionista</h1>
      <p class="muted">Gestão de tutores, animais e agendamentos</p>
    </div>
  </section>

  <section class="panel panel-soft">
    <div class="panel-head">
      <h2>Ações principais</h2>
      <p class="muted">Operações do dia-a-dia</p>
    </div>

    <div class="actions">
      <a class="btn btn-primary"
         href="<%= request.getContextPath() %>/utilizadores/tutores">
        Tutores
      </a>

      <a class="btn btn-primary"
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
