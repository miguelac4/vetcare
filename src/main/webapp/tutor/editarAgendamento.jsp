<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/20/2025
  Time: 8:46 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>
<%@ page import="java.time.LocalDateTime" %>

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
    Agendamento ag = (Agendamento) request.getAttribute("agendamento");
    if (ag == null) {
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>VetCare — Marcação</title>
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

  <div class="user-badge">
    <span class="role-pill"><%= roleLabel %></span>
  </div>

</header>

<main class="content">
    <section class="panel" style="max-width: 720px; margin: 24px auto;">
        <div class="panel-head">
            <h1>Marcação não encontrada</h1>
            <p class="muted">Não foi possível carregar os dados desta marcação.</p>
        </div>

        <div class="actions">
            <a class="btn btn-secondary" href="<%= request.getContextPath() %>/tutor/agendamentos"><-Voltar</a>
        </div>
    </section>
</main>

<footer class="footer">© 2025 VetCare — Sistema de Gestão</footer>
</body>
</html>
<%
        return;
    }

    String erro = (String) request.getAttribute("erro");

    LocalDateTime dh = ag.getDataHora();
    String data = (dh == null) ? "" : dh.toLocalDate().toString(); // YYYY-MM-DD
    String hora = (dh == null) ? "" : dh.toLocalTime().withSecond(0).withNano(0).toString(); // HH:mm
%>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>VetCare — Editar marcação</title>
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
</header>

<main class="content">
    <section class="page-head">
        <div>
            <h1>Editar marcação</h1>
            <p class="muted">Altera data/hora e (se permitido) a localidade.</p>
        </div>

        <div class="page-actions">
            <a class="btn btn-secondary" href="<%= request.getContextPath() %>/tutor/agendamentos">Voltar</a>
        </div>
    </section>

    <section class="panel" style="max-width: 720px;">
        <div class="panel-head">
            <h2>Dados da marcação</h2>
            <p class="muted">ID #<%= ag.getIdAgendamento() %></p>
        </div>

        <% if (erro != null) { %>
        <div class="panel" style="border-color:#ffd6d6; background:#fff5f5; box-shadow:none; margin-top:10px;">
            <p style="margin:0; font-weight:800; color:#c92a2a;"><%= erro %></p>
        </div>
        <% } %>

        <form method="post"
              action="<%= request.getContextPath() %>/tutor/agendamento/editar"
              class="panel"
              style="box-shadow:none; border:none; padding:0; margin-top:14px;">

            <input type="hidden" name="idAgendamento" value="<%= ag.getIdAgendamento() %>"/>
            <input type="hidden" name="idServico" value="<%= ag.getIdServico() %>"/>

            <div style="display:grid; gap:12px;">

                <div style="display:grid; gap:8px;">
                    <label style="font-weight:900;">Data</label>
                    <input class="input" type="date" name="data" value="<%= data %>" required />
                </div>

                <div style="display:grid; gap:8px;">
                    <label style="font-weight:900;">Hora</label>
                    <input class="input" type="time" name="hora" value="<%= hora %>" required />
                </div>

                <div style="display:grid; gap:8px;">
                    <label style="font-weight:900;">Localidade</label>
                    <input class="input" type="text" name="localidade"
                           value="<%= ag.getLocalidade() == null ? "" : ag.getLocalidade() %>"
                           maxlength="50" />
                    <p class="muted" style="font-size:0.95rem;">
                        Nota: se a tua lógica no servidor não permitir mudar localidade, podes manter este campo só para leitura.
                    </p>
                </div>

                <div class="actions" style="margin-top:6px;">
                    <button class="btn btn-primary" type="submit">Guardar alterações</button>
                    <a class="btn btn-secondary" href="<%= request.getContextPath() %>/tutor/agendamentos">Cancelar</a>
                </div>

            </div>
        </form>
    </section>
</main>

<footer class="footer">© 2025 VetCare — Sistema de Gestão</footer>
</body>
</html>
