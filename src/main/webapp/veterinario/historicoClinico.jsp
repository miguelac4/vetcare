<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/24/2025
  Time: 12:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.HistoricoClinico" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
  Integer idAnimal = (Integer) request.getAttribute("idAnimal");
  List<HistoricoClinico> hist = (List<HistoricoClinico>) request.getAttribute("historico");

  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

  String ok = request.getParameter("ok");
  String erro = request.getParameter("erro");
  String erroMsg = (String) request.getAttribute("erro");
%>

<html>
<head>
  <title>Histórico Clínico</title>
</head>
<body>

<h2>Histórico Clínico — Animal #<%= idAnimal %></h2>

<a href="<%= request.getContextPath() %>/veterinario/lista-chamada">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<% if ("1".equals(ok)) { %>
<p style="color:green;">Registo clínico adicionado com sucesso.</p>
<% } %>

<% if ("1".equals(erro)) { %>
<p style="color:red;">Não foi possível adicionar o registo clínico.</p>
<% } %>

<% if (erroMsg != null) { %>
<p style="color:red;"><%= erroMsg %></p>
<% } %>

<h3>Novo registo</h3>

<form method="post" action="<%= request.getContextPath() %>/veterinario/historico-clinico">
  <input type="hidden" name="idAnimal" value="<%= idAnimal %>" />

  <label>Descrição:</label><br/>
  <textarea name="descricao" rows="5" cols="80" required></textarea><br/><br/>

  <button type="submit">Guardar</button>
</form>

<hr/>

<h3>Registos anteriores</h3>

<% if (hist == null || hist.isEmpty()) { %>
<p>Sem registos.</p>
<% } else { %>
<table border="1" cellpadding="6">
  <tr>
    <th>Data/Hora</th>
    <th>Veterinário</th>
    <th>Descrição</th>
  </tr>

  <% for (HistoricoClinico h : hist) { %>
  <tr>
    <td><%= h.getCriadoEm() == null ? "" : h.getCriadoEm().format(dtf) %></td>
    <td><%= h.getNomeVeterinario() == null ? h.getNumLicenca() : h.getNomeVeterinario() %></td>
    <td><%= h.getDescricao() %></td>
  </tr>
  <% } %>
</table>
<% } %>

</body>
</html>
