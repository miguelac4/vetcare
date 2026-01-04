<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 5:59 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.User" %>

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
  <title>VetCare — Gerente | Rececionistas</title>
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
      <h1>Rececionistas</h1>
      <p class="muted">Gestão de contas de rececionistas</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/gerente/utilizadores">
        ← Voltar
      </a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Lista</h2>
      <p class="muted">Clique em “Editar” para alterar nome e email</p>
    </div>

    <%
      List<User> rececionistas = (List<User>) request.getAttribute("rececionistas");
      if (rececionistas == null || rececionistas.isEmpty()) {
    %>
      <p class="muted">Sem rececionistas para mostrar.</p>
    <%
      } else {
    %>

    <table class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Email</th>
        <th class="col-actions">Ações</th>
      </tr>
      </thead>

      <tbody>
      <%
        for (User u : rececionistas) {
      %>
      <tr>
        <td data-label="ID"><%= u.getId() %></td>
        <td data-label="Nome"><%= u.getNome() %></td>
        <td data-label="Email"><%= u.getEmail() %></td>
        <td data-label="Ações" class="td-actions">
          <a class="btn btn-secondary btn-sm"
             href="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas/editar?id=<%= u.getId() %>">
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
