<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/21/2025
  Time: 6:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    List<Agendamento> ags = (List<Agendamento>) request.getAttribute("agendamentos");
    DateTimeFormatter dfData = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    DateTimeFormatter dfHora = DateTimeFormatter.ofPattern("HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Marcações sem veterinário</title>
</head>
<body>

<h2>Marcações sem veterinário</h2>

<a href="<%= request.getContextPath() %>/veterinario/home.jsp">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<% if (ags == null || ags.isEmpty()) { %>
<p>Não existem marcações sem veterinário.</p>
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
        <th>Criado por</th>
    </tr>

    <% for (Agendamento a : ags) {
        LocalDateTime dt = a.getDataHora();
        String data = (dt == null) ? "" : dt.format(dfData);
        String hora = (dt == null) ? "" : dt.format(dfHora);
    %>
    <tr>
        <td><%= a.getIdAgendamento() %></td>
        <td><%= data %></td>
        <td><%= hora %></td>
        <td><%= a.getNomeAnimal() == null ? "" : a.getNomeAnimal() %></td>
        <td><%= a.getTipoServico() == null ? "" : a.getTipoServico() %></td>
        <td><%= a.getLocalidade() == null ? "" : a.getLocalidade() %></td>
        <td><%= a.getEstado() == null ? "" : a.getEstado() %></td>
        <td><%= a.getCriadoPor() == null ? "" : a.getCriadoPor() %></td>
    </tr>
    <% } %>
</table>

<% } %>

</body>
</html>

