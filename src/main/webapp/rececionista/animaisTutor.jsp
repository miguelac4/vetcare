<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/12/2025
  Time: 8:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Animal" %>

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
  <title>VetCare — Animais do Tutor</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/rececionista/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/rececionista/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/utilizadores/tutores">Tutores</a>
    <a href="<%= request.getContextPath() %>/rececionista/agendamentos">Agendamentos</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>

  <!-- badge do role -->
  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>

</header>

<main class="content">
  <%
    String nif = (String) request.getAttribute("nif");
    List<Animal> animais = (List<Animal>) request.getAttribute("animais");
  %>

  <section class="page-head">
    <div>
      <h1>Animais do Tutor</h1>
      <p class="muted">NIF: <strong><%= nif == null ? "" : nif %></strong></p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/utilizadores/tutores">← Voltar</a>

      <a class="btn btn-primary" href="<%= request.getContextPath() %>/rececionista/animal/novo?nif=<%= nif %>">
        + Adicionar Animal
      </a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Registos</h2>
      <p class="muted">--Consulta e edita os animais deste tutor--</p>
    </div>

    <%
      if (animais == null || animais.isEmpty()) {
    %>
      <p class="muted">Este tutor não tem animais registados.</p>
    <%
      } else {
    %>

    <div class="table-wrap">
      <table class="table table-wide">
        <thead>
        <tr>
          <th>ID</th>
          <th>Nome</th>
          <th>Raça</th>
          <th>Sexo</th>
          <th>Data Nascimento</th>
          <th>Estado Reprodutivo</th>
          <th>Alergia</th>
          <th>Cor</th>
          <th>Peso</th>
          <th>Distintivas</th>
          <th>Nº Chip</th>
          <th>Fotografia</th>
          <th class="col-actions">Ações</th>
        </tr>
        </thead>
        <tbody>
        <%
          for (Animal a : animais) {
        %>
        <tr>
          <td data-label="ID"><%= a.getIdAnimal() %></td>
          <td data-label="Nome"><%= a.getNome() == null ? "" : a.getNome() %></td>
          <td data-label="Raça"><%= a.getRaca() == null ? "" : a.getRaca() %></td>
          <td data-label="Sexo"><%= a.getSexo() == null ? "" : a.getSexo() %></td>
          <td data-label="Data Nascimento"><%= a.getDataNascimento() == null ? "" : a.getDataNascimento() %></td>
          <td data-label="Estado Reprodutivo"><%= a.getEstadoReprodutivo() == null ? "" : a.getEstadoReprodutivo() %></td>
          <td data-label="Alergia"><%= a.getAlergia() == null ? "" : a.getAlergia() %></td>
          <td data-label="Cor"><%= a.getCor() == null ? "" : a.getCor() %></td>
          <td data-label="Peso"><%= a.getPeso() == null ? "" : a.getPeso() %></td>
          <td data-label="Distintivas"><%= a.getDistintivas() == null ? "" : a.getDistintivas() %></td>
          <td data-label="Nº Chip"><%= a.getNumChip() == null ? "" : a.getNumChip() %></td>

          <td data-label="Fotografia">
            <%
              String foto = a.getFotografia();
              if (foto != null && !foto.isBlank()) {
            %>
              <a class="link" href="<%= request.getContextPath() + foto %>" target="_blank">Ver</a>
            <%
              } else {
            %>
              <span class="muted">-</span>
            <%
              }
            %>
          </td>
          <td data-label="Ações" class="td-actions">
            <a class="btn btn-secondary btn-sm"
             href="<%= request.getContextPath() %>/rececionista/animal/editar?id=<%= a.getIdAnimal() %>">
            Editar
            </a>
          </td>
        </tr>
        <%
          }
        %>
        </tbody>
      </table>
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
