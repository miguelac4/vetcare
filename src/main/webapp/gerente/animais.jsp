<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 3:59 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.example.vetcare.model.Animal" %>

<%
  List<Animal> animais = (List<Animal>) request.getAttribute("animais");
%>

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
  <title>VetCare — Gerente — Animais</title>
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
      <h1>Lista de Animais</h1>
      <p class="muted">Exportação de dados (JSON) por animal</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/gerente/home.jsp">Voltar</a>
    </div>
  </section>

  <section class="panel panel-soft">
    <div class="panel-head">
      <h2>Registos</h2>
      <p class="muted">Escolhe um animal para exportar</p>
    </div>

    <% if (animais == null || animais.isEmpty()) { %>
      <p class="muted">Não existem animais registados.</p>
    <% } else { %>

      <table class="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Nome</th>
            <th class="col-actions">Ações</th>
          </tr>
        </thead>

        <tbody>
        <% for (Animal a : animais) { %>
          <tr>
            <td data-label="ID"><%= a.getIdAnimal() %></td>
            <td data-label="Nome"><%= a.getNome() %></td>
            <td data-label="Ações" class="td-actions">
              <a class="btn btn-secondary btn-sm"
                 href="<%= request.getContextPath() %>/gerente/animais/exportar-json?idAnimal=<%= a.getIdAnimal() %>">
                Exportar JSON
              </a>
            </td>
          </tr>
        <% } %>
        </tbody>
      </table>

    <% } %>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>

</body>
</html>
