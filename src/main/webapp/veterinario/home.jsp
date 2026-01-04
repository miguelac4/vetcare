<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/12/2025
  Time: 3:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String nome = (String) session.getAttribute("userNome");
  String role = (String) session.getAttribute("userRole");

  String roleLabel = role;
  if ("veterinario".equals(role)) roleLabel = "Veterinário";
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Home Veterinario</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/veterinario/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/veterinario/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/veterinario/procurar-tutores">Tutores</a>
    <a href="<%= request.getContextPath() %>/veterinario/lista-chamada">Lista de Chamada</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>

  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>
</header>


<main class="content">
  <section class="page-head">
    <div>
      <h1> Home - Veterinário </h1>
      <p class="muted">Gestão clínica e marcações.</p>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2> Ações </h2>
      <p class="muted">O que pretende fazer?</p>
    </div>
    <div class="actions">
      <a class="btn btn-primary"
        href="<%= request.getContextPath() %>/veterinario/procurar-tutores">
          Procurar Tutor
      </a>

      <a class="btn btn-primary"
        href="<%= request.getContextPath() %>/veterinario/agendamentos/sem-veterinario">
          Marcações sem veterinário
      </a>

      <a class="btn btn-primary"
         href="<%= request.getContextPath() %>/veterinario/lista-chamada">
        Lista de Chamada
      </a>
    </div>
  </section>
</main>

<footer class="footer">
    @ 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
