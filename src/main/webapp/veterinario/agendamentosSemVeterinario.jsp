<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/21/2025
  Time: 6:01 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>
<%@ page import="java.time.LocalDateTime" %>
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
    List<Agendamento> ags = (List<Agendamento>) request.getAttribute("agendamentos");
    DateTimeFormatter dfData = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    DateTimeFormatter dfHora = DateTimeFormatter.ofPattern("HH:mm");
%>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>VetCare — Marcações sem veterinário</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
    <a class="logo" href="<%= request.getContextPath() %>/veterinario/home.jsp">🐾 vetCare</a>

    <nav class="nav">
      <a href="<%= request.getContextPath() %>/veterinario/home.jsp">Home</a>
      <a href="<%= request.getContextPath() %>/veterinario/agendamentos/sem-veterinario">Sem veterinário</a>
      <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
    </nav>

   <div class="user-badge">
     <span class="role-pill"><%= roleLabel %></span>
  </div>
</header>

<main class="content">

    <section class="page-head">
        <div>
            <h1>Marcações sem veterinário</h1>
            <p class="muted">Assume uma marcação para a tua lista</p>
        </div>
    </section>

    <section class="panel">
        <div class="panel-head">
            <h2>Registos</h2>
            <p class="muted">Apenas marcações sem veterinário atribuído</p>
        </div>

        <% if (ags == null || ags.isEmpty()) { %>
            <p class="muted">Não existem marcações sem veterinário.</p>
        <% } else { %>

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
                <th>Criado por</th>
                <th class="col-actions">Ações</th>
            </tr>
            </thead>

            <tbody>
            <% for (Agendamento a : ags) {
                LocalDateTime dt = a.getDataHora();
                String data = (dt == null) ? "" : dt.format(dfData);
                String hora = (dt == null) ? "" : dt.format(dfHora);
            %>
            <tr>
                <td data-label="ID"><%= a.getIdAgendamento() %></td>
                <td data-label="Data"><%= data %></td>
                <td data-label="Hora"><%= hora %></td>
                <td data-label="Animal"><%= a.getNomeAnimal() == null ? "" : a.getNomeAnimal() %></td>
                <td data-label="Serviço"><%= a.getTipoServico() == null ? "" : a.getTipoServico() %></td>
                <td data-label="Localidade"><%= a.getLocalidade() == null ? "" : a.getLocalidade() %></td>
                <td data-label="Estado"><%= a.getEstado() == null ? "" : a.getEstado() %></td>
                <td data-label="Criado por"><%= a.getCriadoPor() == null ? "" : a.getCriadoPor() %></td>

                <td data-label="Ações" class="td-actions">
                    <form method="post"
                          action="<%= request.getContextPath() %>/veterinario/agendamentos/assumir"
                          style="display:inline; margin:0;">
                        <input type="hidden" name="idAgendamento" value="<%= a.getIdAgendamento() %>" />
                        <button class="btn btn-primary btn-sm" type="submit">Assumir</button>
                    </form>
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
