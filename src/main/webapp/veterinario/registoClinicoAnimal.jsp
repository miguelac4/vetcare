<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/21/2025
  Time: 10:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.vetcare.model.Animal" %>
<%@ page import="org.example.vetcare.model.Taxonomia" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.temporal.ChronoUnit" %>

<%
  Animal a = (Animal) request.getAttribute("animal");
  Taxonomia t = (Taxonomia) request.getAttribute("taxonomia");

  if (a == null) {
%>
<h2>Animal não encontrado.</h2>
<a href="<%= request.getContextPath() %>/veterinario/procurar-tutores">Voltar</a>
<%
    return;
  }

  LocalDate nascimento = a.getDataNascimento();
  LocalDate hoje = LocalDate.now();

  String idadeTxt = "-";
  String escalao = "-";

  if (nascimento != null && !hoje.isBefore(nascimento)) {
    long dias = ChronoUnit.DAYS.between(nascimento, hoje);
    long semanas = dias / 7;
    long meses = ChronoUnit.MONTHS.between(nascimento, hoje);
    long anos = ChronoUnit.YEARS.between(nascimento, hoje);

    // unidade mais legível
    if (dias < 14) {
      idadeTxt = dias + " dias";
    } else if (semanas < 10) {
      idadeTxt = semanas + " semanas";
    } else if (meses < 24) {
      idadeTxt = meses + " meses";
    } else {
      idadeTxt = anos + " anos";
    }

    // escalão etário (ajustável)
    // bebé: < 6 meses
    // jovem: 6-24 meses
    // adulto: 2-8 anos
    // idoso: >= 8 anos
    if (meses < 6) escalao = "bebé";
    else if (meses < 24) escalao = "jovem";
    else if (anos < 8) escalao = "adulto";
    else escalao = "idoso";
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Registo Clínico - <%= a.getNome() %></title>
</head>
<body>

<h2>Registo Clínico</h2>

<a href="javascript:history.back()">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<h3><%= a.getNome() %></h3>

<p>
  <b>Taxonomia:</b>
  <%
    if (t != null) {
  %>
  <%= (t.getEspecie() == null ? "" : t.getEspecie()) %>
  <%= (t.getRaca() == null ? "" : " - " + t.getRaca()) %>
  <%
  } else {
  %>
  -
  <%
    }
  %>
</p>

<p>
  <b>Data de nascimento:</b> <%= nascimento == null ? "-" : nascimento %><br/>
  <b>Data atual:</b> <%= hoje %><br/>
  <b>Idade:</b> <%= idadeTxt %><br/>
  <b>Escalão etário:</b> <%= escalao %>
</p>

</body>
</html>


