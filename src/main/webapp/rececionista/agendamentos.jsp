<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 2:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>

<html>
<head>
  <title>Agendamentos</title>
</head>
<body>

<h2>Agendamentos</h2>

<a href="<%= request.getContextPath() %>/rececionista/home.jsp">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<%
  List<Agendamento> ags = (List<Agendamento>) request.getAttribute("agendamentos");
  if (ags == null || ags.isEmpty()) {
%>
<p>Sem agendamentos.</p>
<%
} else {
%>
<table border="1" cellpadding="6">
  <tr>
    <th>ID</th>
    <th>Data/Hora</th>
    <th>Estado</th>
    <th>Criado Por</th>
    <th>Localidade</th>
    <th>Serviço</th>
    <th>Animal</th>
    <th>Ações</th>
  </tr>

  <%
    for (Agendamento a : ags) {
  %>
  <tr>
    <td><%= a.getIdAgendamento() %></td>
    <td><%= a.getDataHora() == null ? "" : a.getDataHora() %></td>
    <td><%= a.getEstado() == null ? "" : a.getEstado() %></td>
    <td><%= a.getCriadoPor() == null ? "" : a.getCriadoPor() %></td>
    <td><%= a.getLocalidade() == null ? "" : a.getLocalidade() %></td>
    <td><%= a.getTipoServico() == null ? "" : a.getTipoServico() %></td>
    <td><%= a.getNomeAnimal() == null ? "" : a.getNomeAnimal() %></td>

    <td>
      <a href="<%= request.getContextPath() %>/rececionista/agendamento/reagendar?id=<%= a.getIdAgendamento() %>">
        Reagendar
      </a>

      <form action="<%= request.getContextPath() %>/rececionista/agendamento/cancelar"
            method="post" style="display:inline;">
        <input type="hidden" name="idAgendamento" value="<%= a.getIdAgendamento() %>"/>
        <button type="submit"
                onclick="return confirm('Cancelar este agendamento?');">
          Cancelar
        </button>
      </form>
    </td>
  </tr>
  <%
    }
  %>
</table>
<%
  }
%>

</body>
</html>
