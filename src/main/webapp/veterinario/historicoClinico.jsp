<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:18 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.HistoricoClinico" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
  String nome = (String) session.getAttribute("userNome");
  String role = (String) session.getAttribute("userRole");

  String roleLabel = role;
  if ("gerente".equals(role)) roleLabel = "Gerente";
  else if ("veterinario".equals(role)) roleLabel = "Veterinário";
  else if ("tutor".equals(role)) roleLabel = "Tutor";
  else if ("rececionista".equals(role)) roleLabel = "Rececionista";
%>

<%
  Integer idAnimal = (Integer) request.getAttribute("idAnimal");
  List<HistoricoClinico> hist = (List<HistoricoClinico>) request.getAttribute("historico");

  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

  String ok = request.getParameter("ok");
  String erro = request.getParameter("erro");
  String erroMsg = (String) request.getAttribute("erro");
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Histórico Clínico</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/veterinario/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/veterinario/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/veterinario/procurar-tutores">Tutores</a>
    <a href="<%= request.getContextPath() %>/veterinario/lista-chamada">Lista de Chamada</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>
  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>

</header>

<main class="content">
  <section class="page-head">
    <div>
      <h1>Histórico Clínico</h1>
      <p class="muted">Animal #<%= idAnimal %></p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary"
         href="<%= request.getContextPath() %>/veterinario/lista-chamada">
        Voltar
      </a>
    </div>
  </section>

  <%-- Alerts (ok/erro) --%>
  <% if ("1".equals(ok)) { %>
    <section class="panel" style="border-color:#d3f9d8; background:#ebfbee; box-shadow:none; margin-top: 0;">
      <p style="margin:0; font-weight:900; color:#2b8a3e;">Registo clínico adicionado com sucesso.</p>
    </section>
  <% } %>

  <% if ("1".equals(erro)) { %>
    <section class="panel" style="border-color:#ffd6d6; background:#fff5f5; box-shadow:none; margin-top: 10px;">
      <p style="margin:0; font-weight:900; color:#c92a2a;">Não foi possível adicionar o registo clínico.</p>
    </section>
  <% } %>

  <% if (erroMsg != null) { %>
    <section class="panel" style="border-color:#ffd6d6; background:#fff5f5; box-shadow:none; margin-top: 10px;">
      <p style="margin:0; font-weight:900; color:#c92a2a;"><%= erroMsg %></p>
    </section>
  <% } %>

  <section class="panel">
    <div class="panel-head">
      <h2>Novo registo</h2>
      <p class="muted">Adicione notas clínicas para este animal</p>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/veterinario/historico-clinico">
      <input type="hidden" name="idAnimal" value="<%= idAnimal %>" />

      <div style="display:grid; gap:10px; max-width: 900px;">
        <label style="font-weight:900;">Descrição</label>
        <textarea name="descricao" rows="6" required class="input"
                  style="resize: vertical; font-weight:700;"></textarea>

        <div class="actions" style="margin-top: 6px;">
          <button type="submit" class="btn btn-primary">Guardar</button>
          <a class="btn btn-secondary" href="<%= request.getContextPath() %>/veterinario/lista-chamada">Cancelar</a>
        </div>
      </div>
    </form>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Registos anteriores</h2>
      <p class="muted">Histórico do animal</p>
    </div>

    <% if (hist == null || hist.isEmpty()) { %>
      <p class="muted">Sem registos.</p>
    <% } else { %>

    <table class="table">
      <thead>
      <tr>
        <th>Data/Hora</th>
        <th>Veterinário</th>
        <th>Descrição</th>
      </tr>
      </thead>

      <tbody>
      <% for (HistoricoClinico h : hist) { %>
      <tr>
        <td data-label="Data/Hora"><%= h.getCriadoEm() == null ? "" : h.getCriadoEm().format(dtf) %></td>
        <td data-label="Veterinário"><%= h.getNomeVeterinario() == null ? h.getNumLicenca() : h.getNomeVeterinario() %></td>
        <td data-label="Descrição"><%= h.getDescricao() %></td>
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
