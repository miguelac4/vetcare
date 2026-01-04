<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/12/2025
  Time: 3:07 PM
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
  <title>VetCare — Home Gerente</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>

<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/gerente/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/gerente/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/gerente/utilizadores">Utilizadores</a>
    <a href="<%= request.getContextPath() %>/gerente/animais">Animais</a>
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
      <h1>Área do Gerente</h1>
      <p class="muted">Gestão global do sistema VetCare</p>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Gestão</h2>
      <p class="muted">Acesso rápido às funcionalidades administrativas</p>
    </div>

    <div class="actions">
      <a class="btn btn-primary"
         href="<%= request.getContextPath() %>/gerente/utilizadores">
        Gerir Utilizadores
      </a>
      <a class="btn btn-primary"
         href="<%= request.getContextPath() %>/gerente/animais">
        Animais
      </a>
    </div>
  </section>

</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>

</body>
</html>
