<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/21/2025
  Time: 1:19 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<%
  Animal animal = (Animal) request.getAttribute("animal");
  Animal pai = (Animal) request.getAttribute("pai");
  Animal mae = (Animal) request.getAttribute("mae");

  Animal avoPaterno = (Animal) request.getAttribute("avoPaterno");
  Animal avoPaterna = (Animal) request.getAttribute("avoPaterna");
  Animal avoMaterno = (Animal) request.getAttribute("avoMaterno");
  Animal avoMaterna = (Animal) request.getAttribute("avoMaterna");

  String ctx = request.getContextPath();

  if (animal == null) {
%>
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Árvore Genealógica</title>
  <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>
<body>
<header class="topbar">
  <a class="logo" href="<%= ctx %>/veterinario/home.jsp">🐾 vetCare</a>
  <nav class="nav">
    <a href="<%= ctx %>/veterinario/home.jsp">Home</a>
    <a class="nav-logout" href="<%= ctx %>/logout">Sair</a>
  </nav>

  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>

</header>

<main class="content">
  <section class="panel">
    <div class="panel-head">
      <h1>Árvore Genealógica</h1>
      <p class="muted">Animal não encontrado.</p>
    </div>

    <div class="actions">
      <a class="btn btn-secondary" href="javascript:history.back()">Voltar</a>
    </div>
  </section>
</main>

<footer class="footer">© 2025 VetCare — Sistema de Gestão</footer>
</body>
</html>
<%
    return;
  }
%>

<%
  String nif = (String) request.getAttribute("nif");
  String backClinico = ctx + "/veterinario/animal/registro-clinico?id=" + animal.getIdAnimal()
          + (nif != null && !nif.isBlank() ? "&nif=" + nif : "");
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Árvore Genealógica</title>
  <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= ctx %>/veterinario/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= ctx %>/veterinario/home.jsp">Home</a>
    <a href="<%= ctx %>/veterinario/agendamentos/sem-veterinario">Marcações</a>
    <a class="nav-logout" href="<%= ctx %>/logout">Sair</a>
  </nav>
</header>

<main class="content">

  <section class="page-head">
    <div>
      <h1>Árvore Genealógica</h1>
      <p class="muted">
        Animal: <b><%= animal.getNome() %></b> (#<%= animal.getIdAnimal() %>)
      </p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= backClinico %>">Voltar ao registo clínico</a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Família</h2>
      <p class="muted">Avós → Pais → Animal</p>
    </div>

    <table class="table">
      <thead>
      <tr>
        <th>Avós</th>
        <th>Pais</th>
        <th>Animal</th>
      </tr>
      </thead>

      <tbody>
      <tr>
        <td data-label="Avós">
          <b>Avô paterno:</b>
          <%
            if (avoPaterno != null) {
          %>
            <a class="link" href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoPaterno.getIdAnimal() %>">
              <%= avoPaterno.getNome() %> (#<%= avoPaterno.getIdAnimal() %>)
            </a>
          <%
            } else { out.print("<span class='muted'>-</span>"); }
          %>
          <br/>

          <b>Avó paterna:</b>
          <%
            if (avoPaterna != null) {
          %>
            <a class="link" href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoPaterna.getIdAnimal() %>">
              <%= avoPaterna.getNome() %> (#<%= avoPaterna.getIdAnimal() %>)
            </a>
          <%
            } else { out.print("<span class='muted'>-</span>"); }
          %>

          <br/><br/>

          <b>Avô materno:</b>
          <%
            if (avoMaterno != null) {
          %>
            <a class="link" href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoMaterno.getIdAnimal() %>">
              <%= avoMaterno.getNome() %> (#<%= avoMaterno.getIdAnimal() %>)
            </a>
          <%
            } else { out.print("<span class='muted'>-</span>"); }
          %>
          <br/>

          <b>Avó materna:</b>
          <%
            if (avoMaterna != null) {
          %>
            <a class="link" href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= avoMaterna.getIdAnimal() %>">
              <%= avoMaterna.getNome() %> (#<%= avoMaterna.getIdAnimal() %>)
            </a>
          <%
            } else { out.print("<span class='muted'>-</span>"); }
          %>
        </td>

        <td data-label="Pais">
          <b>Pai:</b>
          <%
            if (pai != null) {
          %>
            <a class="link" href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= pai.getIdAnimal() %>">
              <%= pai.getNome() %> (#<%= pai.getIdAnimal() %>)
            </a>
          <%
            } else { out.print("<span class='muted'>-</span>"); }
          %>
          <br/>

          <b>Mãe:</b>
          <%
            if (mae != null) {
          %>
            <a class="link" href="<%= ctx %>/veterinario/animal/registro-clinico?id=<%= mae.getIdAnimal() %>">
              <%= mae.getNome() %> (#<%= mae.getIdAnimal() %>)
            </a>
          <%
            } else { out.print("<span class='muted'>-</span>"); }
          %>
        </td>

        <td data-label="Animal">
          <b><%= animal.getNome() %></b>
          <div class="muted">#<%= animal.getIdAnimal() %></div>
        </td>
      </tr>
      </tbody>
    </table>
  </section>

</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
