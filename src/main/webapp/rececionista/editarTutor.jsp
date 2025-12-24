<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

<%
  Cliente c = (Cliente) request.getAttribute("cliente");
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Editar Tutor</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/rececionista/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/rececionista/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/rececionista/tutores">Tutores</a>
    <a href="<%= request.getContextPath() %>/rececionista/agendamentos">Agendamentos</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>
</header>

<main class="content">

  <section class="page-head">
    <div>
      <h1>Editar Tutor</h1>
      <p class="muted">NIF: <strong><%= c == null ? "" : c.getNif() %></strong></p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/rececionista/tutores">← Voltar</a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Dados do Tutor</h2>
      <p class="muted">Atualiza os campos e guarda as alterações</p>
    </div>

    <%
      if (c == null) {
    %>
      <p class="muted">Tutor não encontrado.</p>
    <%
      } else {
    %>

    <form method="post" action="<%= request.getContextPath() %>/rececionista/tutor/editar" style="margin-top: 14px;">
      <input type="hidden" name="nif" value="<%= c.getNif() %>"/>

      <div style="display:grid; gap:12px; max-width: 900px;">

        <div>
          <label style="font-weight:900;">Nome</label>
          <input class="input" type="text" name="nome" value="<%= c.getNome() == null ? "" : c.getNome() %>" />
        </div>

        <div>
          <label style="font-weight:900;">Sexo</label>
          <select class="input" name="sexo">
            <option value="">-- selecionar --</option>
            <option value="M" <%= "M".equals(c.getSexo()) ? "selected" : "" %>>M</option>
            <option value="F" <%= "F".equals(c.getSexo()) ? "selected" : "" %>>F</option>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Telefone</label>
          <input class="input" type="text" name="telefone" value="<%= c.getTelefone() == null ? "" : c.getTelefone() %>" />
        </div>

        <div>
          <label style="font-weight:900;">Email</label>
          <input class="input" type="email" name="email" value="<%= c.getEmail() == null ? "" : c.getEmail() %>" />
        </div>

        <div>
          <label style="font-weight:900;">Morada</label>
          <input class="input" type="text" name="morada" value="<%= c.getMorada() == null ? "" : c.getMorada() %>" />
        </div>

        <div>
          <label style="font-weight:900;">Freguesia</label>
          <input class="input" type="text" name="freguesia" value="<%= c.getFreguesia() == null ? "" : c.getFreguesia() %>" />
        </div>

        <div>
          <label style="font-weight:900;">Concelho</label>
          <input class="input" type="text" name="concelho" value="<%= c.getConcelho() == null ? "" : c.getConcelho() %>" />
        </div>

        <div>
          <label style="font-weight:900;">Capital Social</label>
          <input class="input" type="number" step="0.01" name="capitalSocial"
                 value="<%= c.getCapitalSocial() == null ? "" : c.getCapitalSocial() %>" />
        </div>

        <div class="actions" style="margin-top: 4px;">
          <button class="btn btn-primary" type="submit">Guardar</button>
          <a class="btn btn-secondary" href="<%= request.getContextPath() %>/rececionista/tutores">Cancelar</a>
        </div>

      </div>
    </form>

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
