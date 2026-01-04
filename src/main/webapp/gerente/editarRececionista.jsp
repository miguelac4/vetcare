<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:41 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.example.vetcare.model.User" %>

<%
  User u = (User) request.getAttribute("user");
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
  <title>VetCare — Editar Rececionista</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/gerente/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/gerente/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas">Rececionistas</a>
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
      <h1>Editar Rececionista</h1>
      <p class="muted">Atualizar dados do utilizador</p>
    </div>
  </section>

  <section class="panel" style="max-width: 520px;">
    <form method="post"
          action="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas/editar">

      <input type="hidden" name="id" value="<%= u.getId() %>"/>

      <div style="display:grid; gap:12px;">
        <label style="font-weight:800;">Nome</label>
        <input class="input"
               type="text"
               name="nome"
               value="<%= u.getNome() %>"
               required />

        <label style="font-weight:800;">Email</label>
        <input class="input"
               type="email"
               name="email"
               value="<%= u.getEmail() %>"
               required />

        <div class="actions" style="margin-top:10px;">
          <button class="btn btn-primary" type="submit">
            Guardar
          </button>

          <a class="btn btn-secondary"
             href="<%= request.getContextPath() %>/gerente/utilizadores/rececionistas">
            Voltar
          </a>
        </div>
      </div>
    </form>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>

</body>
</html>
