<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:01 PM
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

<html>
<head>
    <title>Lista de Chamada</title>
</head>
<body>

<h2>Lista de Chamada (por data/hora)</h2>

<a href="<%= request.getContextPath() %>/veterinario/home.jsp">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<% if (ags == null || ags.isEmpty()) { %>
<p>Não existem agendamentos atribuídos a si.</p>
<% } else { %>

<table border="1" cellpadding="6" cellspacing="0">
    <tr>
        <th>Data</th>
        <th>Hora</th>
        <th>ID</th>
        <th>Animal</th>
        <th>Serviço</th>
        <th>Localidade</th>
        <th>Estado</th>
        <th>Ações</th>
    </tr>

    <% for (Agendamento a : ags) {
        LocalDateTime dt = a.getDataHora();
        String data = (dt == null) ? "" : dt.format(dfData);
        String hora = (dt == null) ? "" : dt.format(dfHora);
    %>
    <tr>
        <td><%= data %></td>
        <td><%= hora %></td>
        <td><%= a.getIdAgendamento() %></td>
        <td><%= a.getNomeAnimal() == null ? "" : a.getNomeAnimal() %></td>
        <td><%= a.getTipoServico() == null ? "" : a.getTipoServico() %></td>
        <td><%= a.getLocalidade() == null ? "" : a.getLocalidade() %></td>
        <td><%= a.getEstado() == null ? "" : a.getEstado() %></td>
        <td>
            <form method="post" action="<%= request.getContextPath() %>/veterinario/agendamentos/desassumir" style="margin:0;">
                <input type="hidden" name="idAgendamento" value="<%= a.getIdAgendamento() %>"/>
                <button type="submit">Desassumir</button>
            </form>
        </td>

    </tr>
    <% } %>
</table>

<% } %>

</body>
</html>
