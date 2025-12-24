<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 3:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>
<%@ page import="org.example.vetcare.model.Servico" %>
<%@ page import="org.example.vetcare.model.Clinica" %>

<%
  Agendamento ag = (Agendamento) request.getAttribute("agendamento");
  List<Servico> servicos = (List<Servico>) request.getAttribute("servicos");
  List<Clinica> clinicas = (List<Clinica>) request.getAttribute("clinicas");

  String dataHoraValue = "";
  if (ag != null && ag.getDataHora() != null) {
    dataHoraValue = ag.getDataHora().toString();
    if (dataHoraValue.length() >= 16) dataHoraValue = dataHoraValue.substring(0,16);
  }
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Reagendar</title>
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
      <h1>Reagendar Agendamento</h1>
      <p class="muted">Atualiza data/hora, clínica e serviço</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/rececionista/agendamentos">← Voltar</a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Dados</h2>
      <p class="muted">Ao guardar, o agendamento fica como “reagendado”.</p>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/rececionista/agendamento/reagendar">
      <input type="hidden" name="idAgendamento" value="<%= ag == null ? "" : ag.getIdAgendamento() %>"/>

      <div style="display:grid; gap:12px; max-width: 720px;">
        <div>
          <label style="font-weight:900;">Data/Hora</label>
          <input class="input" type="datetime-local" name="dataHora" value="<%= dataHoraValue %>" required />
        </div>

        <div>
          <label style="font-weight:900;">Localidade</label>
          <select class="input" name="localidade" required>
            <option value="">-- selecionar --</option>
            <%
              if (clinicas != null && ag != null) {
                for (Clinica c : clinicas) {
                  String loc = c.getLocalidade();
                  String selected = (loc != null && loc.equals(ag.getLocalidade())) ? "selected" : "";
            %>
              <option value="<%= loc %>" <%= selected %>><%= loc %></option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Serviço</label>
          <select class="input" name="idServico" required>
            <option value="">-- selecionar --</option>
            <%
              if (servicos != null && ag != null) {
                for (Servico s : servicos) {
                  String selected = (s.getIdServico() == ag.getIdServico()) ? "selected" : "";
            %>
              <option value="<%= s.getIdServico() %>" <%= selected %>><%= s.getTipo() %></option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div class="actions">
          <button class="btn btn-primary" type="submit">Guardar</button>
          <a class="btn btn-secondary" href="<%= request.getContextPath() %>/rececionista/agendamentos">Cancelar</a>
        </div>
      </div>
    </form>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>

</body>
</html>

