<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String nome = (String) session.getAttribute("userNome");
  String role = (String) session.getAttribute("userRole");

  String roleLabel = role;
  if ("tutor".equals(role)) roleLabel = "Tutor";
%>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>VetCare — Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/tutor/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/tutor/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/animais">Animais</a>
    <a href="<%= request.getContextPath() %>/tutor/agendamentos">Marcações</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>

  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>
</header>


<main class="content">
    <section class="page-head">
        <div>
            <h1>Home — Tutor</h1>
            <p class="muted">Gestão dos seus animais e marcações</p>
        </div>
    </section>

    <div class="cards">
        <div class="card">
            <div class="card-title">Animais</div>
            <div class="card-hint">Ver os teus registos</div>
            <div style="margin-top:12px;">
                <a class="btn btn-primary" href="<%= request.getContextPath() %>/animais">
                    Os meus animais
                </a>
            </div>
        </div>

        <div class="card">
            <div class="card-title">Marcações</div>
            <div class="card-hint">Consultar e alterar</div>
            <div style="margin-top:12px;">
                <a class="btn btn-primary" href="<%= request.getContextPath() %>/tutor/agendamentos">
                    Ver marcações
                </a>
            </div>
        </div>
    </div>

</main>

<footer class="footer">
    © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
