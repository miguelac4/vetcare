<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Veterinario" %>

<%
  Veterinario v = (Veterinario) request.getAttribute("vet");
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
  <title>VetCare — Editar Veterinário</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
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
      <h1>Editar Veterinário</h1>
      <p class="muted">Atualizar dados do veterinário</p>
    </div>
  </section>

  <section class="panel" style="max-width:520px;">
    <form method="post"
          action="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios/editar"
          style="display:grid; gap:14px;">

      <input type="hidden" name="id" value="<%= v.getId() %>"/>

      <div>
        <label class="muted">Nome</label>
        <input class="input" name="nome" value="<%= v.getNome() %>" required/>
      </div>

      <div>
        <label class="muted">Email</label>
        <input class="input" name="email" value="<%= v.getEmail() %>" required/>
      </div>

      <div>
        <label class="muted">Nº Licença</label>
        <input class="input" value="<%= v.getNumLicenca() %>" readonly/>
      </div>

      <div class="actions">
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a class="btn btn-secondary"
           href="<%= request.getContextPath() %>/gerente/utilizadores/veterinarios">
          Cancelar
        </a>
      </div>
    </form>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
