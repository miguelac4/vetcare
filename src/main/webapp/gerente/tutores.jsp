<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/22/2025
  Time: 4:14 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

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
  <title>VetCare — Gerente | Tutores</title>
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
      <h1>Lista de Tutores</h1>
      <p class="muted">Gestão de clientes/tutores registados</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/gerente/utilizadores">
        ← Voltar
      </a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Registos</h2>
      <p class="muted">Clique em “Editar” para alterar dados do tutor</p>
    </div>

    <%
      List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
      if (clientes == null || clientes.isEmpty()) {
    %>
      <p class="muted">Sem tutores para mostrar.</p>
    <%
      } else {
    %>

    <table class="table">
      <thead>
      <tr>
        <th>NIF</th>
        <th>Nome</th>
        <th>Email</th>
        <th class="col-actions">Ações</th>
      </tr>
      </thead>

      <tbody>
      <%
        for (Cliente c : clientes) {
      %>
      <tr>
        <td data-label="NIF"><%= c.getNif() %></td>
        <td data-label="Nome"><%= c.getNome() %></td>
        <td data-label="Email"><%= c.getEmail() %></td>
        <td data-label="Ações" class="td-actions">
          <a class="btn btn-secondary btn-sm"
             href="<%= request.getContextPath() %>/gerente/tutor/editar?nif=<%= c.getNif() %>">
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
