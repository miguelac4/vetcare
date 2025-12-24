<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 3:44 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Servico" %>
<%@ page import="org.example.vetcare.model.Clinica" %>
<%@ page import="org.example.vetcare.model.Animal" %>

<%
  List<Servico> servicos = (List<Servico>) request.getAttribute("servicos");
  List<Clinica> clinicas = (List<Clinica>) request.getAttribute("clinicas");
  List<Animal> animais = (List<Animal>) request.getAttribute("animais");
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Criar Agendamento</title>
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
      <h1>Criar Agendamento</h1>
      <p class="muted">Preenche os dados e confirma</p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary"
         href="<%= request.getContextPath() %>/rececionista/agendamentos">
        Voltar
      </a>
    </div>
  </section>

  <section class="panel" style="max-width: 720px;">
    <div class="panel-head">
      <h2>Dados da marcação</h2>
      <p class="muted">Escolhe clínica, serviço e animal</p>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/rececionista/agendamento/criar">
      <div style="display:grid; gap:12px;">

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Data/Hora</label>
          <input class="input" type="datetime-local" name="dataHora" required />
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Localidade (Clínica)</label>
          <select class="input" name="localidade" required>
            <option value="">-- selecionar --</option>
            <%
              for (Clinica c : clinicas) {
            %>
              <option value="<%= c.getLocalidade() %>"><%= c.getLocalidade() %></option>
            <%
              }
            %>
          </select>
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Serviço</label>
          <select class="input" name="idServico" required>
            <option value="">-- selecionar --</option>
            <%
              for (Servico s : servicos) {
            %>
              <option value="<%= s.getIdServico() %>"><%= s.getTipo() %></option>
            <%
              }
            %>
          </select>
        </div>

        <div style="display:grid; gap:8px;">
          <label style="font-weight:800;">Animal</label>
          <select class="input" name="idAnimal" required>
            <option value="">-- selecionar --</option>
            <%
              for (Animal a : animais) {
            %>
              <option value="<%= a.getIdAnimal() %>">
                <%= a.getNome() %> (ID <%= a.getIdAnimal() %>)
              </option>
            <%
              }
            %>
          </select>
        </div>

        <div class="actions" style="margin-top: 8px;">
          <button class="btn btn-primary" type="submit">Criar</button>
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
