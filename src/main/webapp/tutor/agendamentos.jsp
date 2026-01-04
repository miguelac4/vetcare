<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/20/2025
  Time: 8:02 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>

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
  List<Agendamento> agendamentos = (List<Agendamento>) request.getAttribute("agendamentos");

  DateTimeFormatter fmtData = DateTimeFormatter.ofPattern("dd/MM/yyyy");
  DateTimeFormatter fmtHora = DateTimeFormatter.ofPattern("HH:mm");
  LocalDateTime now = LocalDateTime.now();
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>vetCare — As minhas marcações</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/tutor/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/tutor/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/animais">Animais</a>
    <a href="<%= request.getContextPath() %>/tutor/agendamentos">Marcações</a>
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
      <h1>As minhas marcações</h1>
      <p class="muted">Consulta e altera as tuas marcações futuras</p>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Lista</h2>
      <p class="muted">Só podes alterar marcações que ainda não aconteceram</p>
    </div>

    <%
      if (agendamentos == null || agendamentos.isEmpty()) {
    %>
      <p class="muted">Não existem marcações.</p>
    <%
      } else {
    %>

    <table class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Data</th>
        <th>Hora</th>
        <th>Animal</th>
        <th>Serviço</th>
        <th>Localidade</th>
        <th>Estado</th>
        <th class="col-actions">Ações</th>
      </tr>
      </thead>

      <tbody>
      <%
        for (Agendamento a : agendamentos) {
          LocalDateTime dh = a.getDataHora();
          String data = (dh == null) ? "" : dh.format(fmtData);
          String hora = (dh == null) ? "" : dh.format(fmtHora);

          boolean isPassado = (dh != null && dh.isBefore(now));
      %>
      <tr>
        <td data-label="ID"><%= a.getIdAgendamento() %></td>
        <td data-label="Data"><%= data %></td>
        <td data-label="Hora"><%= hora %></td>
        <td data-label="Animal"><%= a.getNomeAnimal() == null ? "" : a.getNomeAnimal() %></td>
        <td data-label="Serviço"><%= a.getTipoServico() == null ? "" : a.getTipoServico() %></td>
        <td data-label="Localidade"><%= a.getLocalidade() == null ? "" : a.getLocalidade() %></td>
        <td data-label="Estado"><%= a.getEstado() == null ? "" : a.getEstado() %></td>

        <td data-label="Ações" class="td-actions">
          <% if (!isPassado) { %>
            <a class="btn btn-secondary btn-sm"
               href="<%= request.getContextPath() %>/tutor/agendamento/editar?id=<%= a.getIdAgendamento() %>">
              Alterar
            </a>
          <% } else { %>
            <span class="muted" style="font-weight:800;">Terminada</span>
          <% } %>
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
