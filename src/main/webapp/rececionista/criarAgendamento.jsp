<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/13/2025
  Time: 3:44 PM
  To change this template use File | Settings | File Templates.
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

<html>
<head>
  <title>Criar Agendamento</title>
</head>
<body>

<h2>Criar Agendamento</h2>

<a href="<%= request.getContextPath() %>/rececionista/agendamentos">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<form method="post" action="<%= request.getContextPath() %>/rececionista/agendamento/criar">

  Data/Hora:
  <input type="datetime-local" name="dataHora" required />
  <br/><br/>

  Localidade (Clínica):
  <select name="localidade" required>
    <option value="">-- selecionar --</option>
    <%
      for (Clinica c : clinicas) {
    %>
    <option value="<%= c.getLocalidade() %>"><%= c.getLocalidade() %></option>
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
    %>
    <option value="<%= s.getIdServico() %>"><%= s.getTipo() %></option>
    <%
      }
    %>
  </select>
  <br/><br/>

  Animal:
  <select name="idAnimal" required>
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
  <br/><br/>

  <button type="submit">Criar</button>
</form>

</body>
</html>
