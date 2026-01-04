<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 3:34 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String nome = (String) session.getAttribute("userNome");
  String role = (String) session.getAttribute("userRole");

  String roleLabel = role;
  if ("gerente".equals(role)) roleLabel = "Gerente";
  else if ("veterinario".equals(role)) roleLabel = "Veterinário";
  else if ("tutor".equals(role)) roleLabel = "Tutor";
  else if ("rececionista".equals(role)) roleLabel = "Rececionista";
%>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>VetCare — Gerente | Utilizadores</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
    <a class="logo" href="<%= request.getContextPath() %>/gerente/home.jsp">🐾 vetCare</a>

    <nav class="nav">
        <a href="<%= request.getContextPath() %>/gerente/home.jsp">Home</a>
        <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
    </nav>

    <%-- Badge do utilizador --%>
    <div class="user-badge">
        <span class="role-pill"><%= roleLabel %></span>
    </div>
</header>

<main class="content">
    <section class="page-head">
        <div>
            <h1>Gestão de Utilizadores</h1>
            <p class="muted">Aceda aos diferentes tipos de utilizadores do sistema</p>
        </div>
    </section>

    <div class="cards">
        <div class="card">
            <div class="card-title">Clientes (Tutores)</div>
            <p class="card-hint">Gerir informação dos tutores</p>
            <br/>
            <a class="btn btn-primary"
               href="<%= request.getContextPath() %>/utilizadores/tutores">
                Ver Tutores
            </a>
        </div>

        <div class="card">
            <div class="card-title">Veterinários</div>
            <p class="card-hint">Gerir veterinários registados</p>
            <br/>
            <a class="btn btn-primary"
               href="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios">
                Ver Veterinários
            </a>
        </div>

        <div class="card">
            <div class="card-title">Rececionistas</div>
            <p class="card-hint">Gerir rececionistas do sistema</p>
            <br/>
            <a class="btn btn-primary"
               href="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas">
                Ver Rececionistas
            </a>
        </div>
    </div>
</main>

<footer class="footer">
    © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
