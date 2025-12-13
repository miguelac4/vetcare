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
  if (ag.getDataHora() != null) {
    dataHoraValue = ag.getDataHora().toString();
    if (dataHoraValue.length() >= 16) dataHoraValue = dataHoraValue.substring(0,16);
  }
%>

<html>
<head>
  <title>Reagendar Agendamento</title>
</head>
<body>

<h2>Reagendar Agendamento</h2>

<a href="<%= request.getContextPath() %>/rececionista/agendamentos">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<form method="post" action="<%= request.getContextPath() %>/rececionista/agendamento/reagendar">
  <input type="hidden" name="idAgendamento" value="<%= ag.getIdAgendamento() %>"/>

  Data/Hora:
  <input type="datetime-local" name="dataHora" value="<%= dataHoraValue %>" required />
  <br/><br/>

  Localidade:
  <select name="localidade" required>
    <option value="">-- selecionar --</option>
    <%
      for (Clinica c : clinicas) {
        String loc = c.getLocalidade();
        String selected = (loc != null && loc.equals(ag.getLocalidade())) ? "selected" : "";
    %>
    <option value="<%= loc %>" <%= selected %>><%= loc %></option>
    <%
      }
    %>
  </select>

  <br/><br/>


  Serviço:
  <select name="idServico" required>
    <option value="">-- selecionar --</option>
    <%
      for (Servico s : servicos) {
        String selected = (s.getIdServico() == ag.getIdServico()) ? "selected" : "";
    %>
    <option value="<%= s.getIdServico() %>" <%= selected %>>
      <%= s.getTipo() %>
    </option>
    <%
      }
    %>
  </select>

  <br/><br/>
  <button type="submit">Guardar (fica Reagendado)</button>
</form>

</body>
</html>

