<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:55 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

<%
  Cliente cliente = (Cliente) request.getAttribute("cliente");
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
  <title>VetCare — Gerente · Editar Tutor</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/gerente/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/gerente/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/utilizadores/tutores">Tutores</a>
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
      <h1>Editar Tutor</h1>
      <p class="muted">Atualizar dados do tutor</p>
    </div>
  </section>

  <section class="panel" style="max-width: 720px;">
    <form method="post" action="<%= request.getContextPath() %>/gerente/tutor/editar">
      <input type="hidden" name="nif" value="<%= cliente.getNif() %>" />

      <div style="display:grid; gap:12px;">
        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">NIF</label>
          <input class="input" type="text" value="<%= cliente.getNif() %>" readonly />
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Nome</label>
          <input class="input" type="text" name="nome" value="<%= cliente.getNome() %>" required />
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Sexo</label>
          <select class="input" name="sexo">
            <option value="">-- selecionar --</option>
            <option value="M" <%= "M".equals(cliente.getSexo()) ? "selected" : "" %>>M</option>
            <option value="F" <%= "F".equals(cliente.getSexo()) ? "selected" : "" %>>F</option>
          </select>
        </div>


        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Telefone</label>
          <input class="input" type="text" name="telefone"
                 value="<%= cliente.getTelefone() == null ? "" : cliente.getTelefone() %>" />
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Email</label>
          <input class="input" type="text" value="<%= cliente.getEmail() %>" readonly />
          <input type="hidden" name="email" value="<%= cliente.getEmail() %>" />
          <p class="muted" style="margin:0;">O email está bloqueado nesta edição.</p>
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Morada</label>
          <input class="input" type="text" name="morada"
                 value="<%= cliente.getMorada() == null ? "" : cliente.getMorada() %>" />
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Freguesia</label>
          <input class="input" type="text" name="freguesia"
                 value="<%= cliente.getFreguesia() == null ? "" : cliente.getFreguesia() %>" />
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Concelho</label>
          <input class="input" type="text" name="concelho"
                 value="<%= cliente.getConcelho() == null ? "" : cliente.getConcelho() %>" />
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Capital Social</label>
          <input class="input" type="text" name="capitalSocial"
                 value="<%= cliente.getCapitalSocial() == null ? "" : cliente.getCapitalSocial() %>" />
        </div>

        <div class="actions" style="margin-top:10px;">
          <button class="btn btn-primary" type="submit">Guardar</button>

          <a class="btn btn-secondary"
             href="<%= request.getContextPath() %>/utilizadores/tutores">
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
