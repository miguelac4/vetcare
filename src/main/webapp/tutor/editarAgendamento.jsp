<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/20/2025
  Time: 8:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Agendamento" %>
<%@ page import="java.time.LocalDateTime" %>

<%
    Agendamento ag = (Agendamento) request.getAttribute("agendamento");
    if (ag == null) {
%>
<h2>Marcação não encontrada.</h2>
<a href="<%= request.getContextPath() %>/tutor/agendamentos">Voltar</a>
<%
        return;
    }

    String erro = (String) request.getAttribute("erro");

    LocalDateTime dh = ag.getDataHora();
    String data = (dh == null) ? "" : dh.toLocalDate().toString(); // YYYY-MM-DD
    String hora = (dh == null) ? "" : dh.toLocalTime().withSecond(0).withNano(0).toString(); // HH:mm
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar marcação</title>
</head>
<body>

<h2>Editar marcação</h2>

<a href="<%= request.getContextPath() %>/tutor/agendamentos">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<% if (erro != null) { %>
<p style="color:red;"><%= erro %></p>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/tutor/agendamento/editar">
    <input type="hidden" name="idAgendamento" value="<%= ag.getIdAgendamento() %>"/>
    <input type="hidden" name="idServico" value="<%= ag.getIdServico() %>"/>

    <label>Data:</label><br/>
    <input type="date" name="data" value="<%= data %>" required />
    <br/><br/>

    <label>Hora:</label><br/>
    <input type="time" name="hora" value="<%= hora %>" required />
    <br/><br/>

    <label>Localidade:</label><br/>
    <input type="text" name="localidade" value="<%= ag.getLocalidade() == null ? "" : ag.getLocalidade() %>" maxlength="50" />
    <br/><br/>

    <button type="submit">Guardar alterações</button>
</form>

</body>
</html>

