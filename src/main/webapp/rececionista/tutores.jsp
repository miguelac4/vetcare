<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/12/2025
  Time: 7:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
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
  <title>VetCare — Tutores</title>
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
      <h1>Tutores</h1>
      <p class="muted">Lista de tutores registados no sistema</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/rececionista/home.jsp">← Voltar</a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Registos</h2>
      <p class="muted">Acede à ficha do cliente e aos respetivos animais</p>
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
        <th>Nome</th>
        <th>Email</th>
        <th class="col-actions">Ficha</th>
        <th class="col-actions">Animais</th>
      </tr>
      </thead>

      <tbody>
      <%
        for (Cliente c : clientes) {
      %>
      <tr>
        <td data-label="Nome"><%= c.getNome() == null ? "" : c.getNome() %></td>
        <td data-label="Email"><%= c.getEmail() == null ? "" : c.getEmail() %></td>

        <td data-label="Ficha" class="td-actions">
          <a class="btn btn-secondary btn-sm"
             href="<%= request.getContextPath() %>/rececionista/ficha-cliente?nif=<%= c.getNif() %>">
            Ficha Cliente
          </a>
        </td>

        <td data-label="Animais" class="td-actions">
          <a class="btn btn-secondary btn-sm"
             href="<%= request.getContextPath() %>/animais?nif=<%= c.getNif() %>">
            Ver Animais
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
