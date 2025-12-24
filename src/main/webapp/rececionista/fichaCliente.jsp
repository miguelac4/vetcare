<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/12/2025
  Time: 8:23 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Cliente" %>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Ficha do Cliente</title>
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

  <%
    Cliente c = (Cliente) request.getAttribute("cliente");
  %>

  <section class="page-head">
    <div>
      <h1>Ficha do Cliente</h1>
      <p class="muted">
        <%
          if (c != null) {
        %>
          NIF: <strong><%= c.getNif() %></strong>
        <%
          } else {
        %>
          Cliente indisponível
        <%
          }
        %>
      </p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/rececionista/tutores">← Voltar</a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Dados do Tutor</h2>
      <p class="muted">Informação completa do cliente</p>
    </div>

    <%
      if (c == null) {
    %>
      <p class="muted">Cliente não encontrado.</p>
    <%
      } else {
    %>

    <table class="table">
      <thead>
        <tr>
          <th>Campo</th>
          <th>Valor</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td data-label="Campo"><strong>NIF</strong></td>
          <td data-label="Valor"><%= c.getNif() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Nome</strong></td>
          <td data-label="Valor"><%= c.getNome() == null ? "" : c.getNome() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Sexo</strong></td>
          <td data-label="Valor"><%= c.getSexo() == null ? "" : c.getSexo() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Telefone</strong></td>
          <td data-label="Valor"><%= c.getTelefone() == null ? "" : c.getTelefone() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Email</strong></td>
          <td data-label="Valor"><%= c.getEmail() == null ? "" : c.getEmail() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Morada</strong></td>
          <td data-label="Valor"><%= c.getMorada() == null ? "" : c.getMorada() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Freguesia</strong></td>
          <td data-label="Valor"><%= c.getFreguesia() == null ? "" : c.getFreguesia() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Concelho</strong></td>
          <td data-label="Valor"><%= c.getConcelho() == null ? "" : c.getConcelho() %></td>
        </tr>

        <tr>
          <td data-label="Campo"><strong>Capital Social</strong></td>
          <td data-label="Valor"><%= c.getCapitalSocial() == null ? "" : c.getCapitalSocial() %></td>
        </tr>
      </tbody>
    </table>

    <div class="actions" style="margin-top: 14px;">
      <a class="btn btn-primary"
         href="<%= request.getContextPath() %>/rececionista/tutor/editar?nif=<%= c.getNif() %>">
        Editar Tutor
      </a>

      <a class="btn btn-secondary"
         href="<%= request.getContextPath() %>/animais?nif=<%= c.getNif() %>">
        Ver Animais
      </a>
    </div>

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
