<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/21/2025
  Time: 10:34 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Animal" %>
<%@ page import="org.example.vetcare.model.Taxonomia" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.ChronoUnit" %>

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
  Animal a = (Animal) request.getAttribute("animal");
  Taxonomia t = (Taxonomia) request.getAttribute("taxonomia");

  if (a == null) {
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Registo Clínico</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body>
<header class="topbar">

  <a class="logo" href="<%= request.getContextPath() %>/veterinario/home.jsp">🐾 vetCare</a>
  <nav class="nav">
    <a href="<%= request.getContextPath() %>/veterinario/procurar-tutores">Voltar</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>
  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>

</header>

<main class="content">
  <section class="panel">
    <div class="panel-head">
      <h1>Animal não encontrado</h1>
      <p class="muted">Não foi possível carregar o registo clínico.</p>
    </div>
    <div class="actions">
      <a class="btn btn-primary" href="<%= request.getContextPath() %>/veterinario/procurar-tutores">Voltar</a>
    </div>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
<%
    return;
  }

  LocalDate nascimento = a.getDataNascimento();
  LocalDate hoje = LocalDate.now();

  String idadeTxt = "-";
  String escalao = "-";

  if (nascimento != null && !hoje.isBefore(nascimento)) {
    long dias = ChronoUnit.DAYS.between(nascimento, hoje);
    long semanas = dias / 7;
    long meses = ChronoUnit.MONTHS.between(nascimento, hoje);
    long anos = ChronoUnit.YEARS.between(nascimento, hoje);

    if (dias < 14) {
      idadeTxt = dias + " dias";
    } else if (semanas < 10) {
      idadeTxt = semanas + " semanas";
    } else if (meses < 24) {
      idadeTxt = meses + " meses";
    } else {
      idadeTxt = anos + " anos";
    }

    if (meses < 6) escalao = "bebé";
    else if (meses < 24) escalao = "jovem";
    else if (anos < 8) escalao = "adulto";
    else escalao = "idoso";
  }

  String nif = (String) request.getAttribute("nif");
  String voltarUrl = (nif != null && !nif.isBlank())
          ? (request.getContextPath() + "/animais?nif=" + nif)
          : (request.getContextPath() + "/veterinario/procurar-tutores");
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Registo Clínico - <%= a.getNome() %></title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/veterinario/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= voltarUrl %>">Voltar</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>
</header>

<main class="content">

  <section class="page-head">
    <div>
      <h1>Registo Clínico</h1>
      <p class="muted"><%= a.getNome() %> — detalhes gerais do animal</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary"
         href="<%= request.getContextPath() %>/veterinario/animal/arvore?id=<%= a.getIdAnimal() %>&nif=<%= (nif == null ? "" : nif) %>">
        Ver árvore genealógica
      </a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Identificação</h2>
      <p class="muted">Dados base e taxonomia</p>
    </div>

    <p style="margin:0;">
      <b>Nome:</b> <%= a.getNome() %><br/>
      <b>Taxonomia:</b>
      <%
        if (t != null) {
      %>
        <%= (t.getEspecie() == null ? "" : t.getEspecie()) %>
        <%= (t.getRaca() == null ? "" : " - " + t.getRaca()) %>
      <%
        } else {
      %>
        -
      <%
        }
      %>
    </p>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Idade e escalão</h2>
      <p class="muted">Cálculo automático com base na data de nascimento</p>
    </div>

    <p style="margin:0;">
      <b>Data de nascimento:</b> <%= nascimento == null ? "-" : nascimento %><br/>
      <b>Data atual:</b> <%= hoje %><br/>
      <b>Idade:</b> <%= idadeTxt %><br/>
      <b>Escalão etário:</b> <%= escalao %>
    </p>
  </section>

</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>

</body>
</html>
