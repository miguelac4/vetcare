<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/20/2025
  Time: 8:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>

<%
  List<Agendamento> agendamentos = (List<Agendamento>) request.getAttribute("agendamentos");

  DateTimeFormatter fmtData = DateTimeFormatter.ofPattern("dd/MM/yyyy");
  DateTimeFormatter fmtHora = DateTimeFormatter.ofPattern("HH:mm");
  LocalDateTime now = LocalDateTime.now();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>As minhas marcações</title>
</head>
<body>

<h2>As minhas marcações</h2>

<a href="<%= request.getContextPath() %>/tutor/home.jsp">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<% if (agendamentos == null || agendamentos.isEmpty()) { %>
<p>Não existem marcações.</p>
<% } else { %>

<table border="1" cellpadding="6" cellspacing="0">
  <tr>
    <th>ID</th>
    <th>Data</th>
    <th>Hora</th>
    <th>Animal</th>
    <th>Serviço</th>
    <th>Localidade</th>
    <th>Estado</th>
    <th>Ações</th>
  </tr>

  <% for (Agendamento a : agendamentos) {
    LocalDateTime dh = a.getDataHora();
    String data = (dh == null) ? "" : dh.format(fmtData);
    String hora = (dh == null) ? "" : dh.format(fmtHora);

    boolean isPassado = (dh != null && dh.isBefore(now));
  %>
  <tr>
    <td><%= a.getIdAgendamento() %></td>
    <td><%= data %></td>
    <td><%= hora %></td>
    <td><%= a.getNomeAnimal() == null ? "" : a.getNomeAnimal() %></td>
    <td><%= a.getTipoServico() == null ? "" : a.getTipoServico() %></td>
    <td><%= a.getLocalidade() == null ? "" : a.getLocalidade() %></td>
    <td><%= a.getEstado() == null ? "" : a.getEstado() %></td>
    <td>
      <% if (!isPassado) { %>
      <a href="<%= request.getContextPath() %>/tutor/agendamento/editar?id=<%= a.getIdAgendamento() %>">Alterar</a>
      <% } else { %>
      <span style="color:gray;">(terminada)</span>
      <% } %>
    </td>
  </tr>
  <% } %>
</table>

<% } %>

</body>
</html>