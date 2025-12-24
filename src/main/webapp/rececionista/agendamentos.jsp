<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 2:45 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Agendamentos</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/rececionista/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/rececionista/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/rececionista/agendamentos">Agendamentos</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>
</header>

<main class="content">
  <section class="page-head">
    <div>
      <h1>Agendamentos</h1>
      <p class="muted">Lista de marcações registadas</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-primary" href="<%= request.getContextPath() %>/rececionista/agendamento/criar">
        + Criar Agendamento
      </a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Registos</h2>
      <p class="muted">Reagende ou cancele diretamente</p>
    </div>

    <%
      List<Agendamento> ags = (List<Agendamento>) request.getAttribute("agendamentos");
      if (ags == null || ags.isEmpty()) {
    %>
      <p class="muted">Sem agendamentos.</p>
    <%
      } else {
    %>

    <table class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Data/Hora</th>
        <th>Estado</th>
        <th>Criado Por</th>
        <th>Localidade</th>
        <th>Serviço</th>
        <th>Animal</th>
        <th class="col-actions">Ações</th>
      </tr>
      </thead>

      <tbody>
      <%
        for (Agendamento a : ags) {
      %>
      <tr>
        <td data-label="ID"><%= a.getIdAgendamento() %></td>
        <td data-label="Data/Hora"><%= a.getDataHora() == null ? "" : a.getDataHora() %></td>
        <td data-label="Estado"><%= a.getEstado() == null ? "" : a.getEstado() %></td>
        <td data-label="Criado Por"><%= a.getCriadoPor() == null ? "" : a.getCriadoPor() %></td>
        <td data-label="Localidade"><%= a.getLocalidade() == null ? "" : a.getLocalidade() %></td>
        <td data-label="Serviço"><%= a.getTipoServico() == null ? "" : a.getTipoServico() %></td>
        <td data-label="Animal"><%= a.getNomeAnimal() == null ? "" : a.getNomeAnimal() %></td>

        <td data-label="Ações" class="td-actions">
          <a class="btn btn-secondary btn-sm"
             href="<%= request.getContextPath() %>/rececionista/agendamento/reagendar?id=<%= a.getIdAgendamento() %>">
            Reagendar
          </a>

          <form action="<%= request.getContextPath() %>/rececionista/agendamento/cancelar"
                method="post" style="display:inline;">
            <input type="hidden" name="idAgendamento" value="<%= a.getIdAgendamento() %>"/>
            <button class="btn btn-secondary btn-sm" type="submit"
                    onclick="return confirm('Cancelar este agendamento?');">
              Cancelar
            </button>
          </form>
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
