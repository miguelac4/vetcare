<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 6:08 PM
--%>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.Veterinario" %>
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
  <title>VetCare — Gerente | Veterinários</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/gerente/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/gerente/utilizadores">Utilizadores</a>
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
      <h1>Veterinários</h1>
      <p class="muted">Lista de veterinários registados no sistema</p>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Registos</h2>
      <p class="muted">Edite os dados de um veterinário</p>
    </div>

    <%
      List<Veterinario> veterinarios = (List<Veterinario>) request.getAttribute("veterinarios");
      if (veterinarios == null || veterinarios.isEmpty()) {
    %>
      <p class="muted">Sem veterinários para mostrar.</p>
    <%
      } else {
    %>

    <table class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Email</th>
        <th>Nº Licença</th>
        <th class="col-actions">Ações</th>
      </tr>
      </thead>

      <tbody>
      <%
        for (Veterinario v : veterinarios) {
      %>
      <tr>
        <td data-label="ID"><%= v.getId() %></td>
        <td data-label="Nome"><%= v.getNome() %></td>
        <td data-label="Email"><%= v.getEmail() %></td>
        <td data-label="Nº Licença"><%= v.getNumLicenca() == null ? "(sem registo)" : v.getNumLicenca() %></td>

        <td data-label="Ações" class="td-actions">
          <a class="btn btn-secondary btn-sm"
             href="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios/editar?id=<%= v.getId() %>">
            Editar
          </a>
        </td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>

    <%
      }
    %>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
