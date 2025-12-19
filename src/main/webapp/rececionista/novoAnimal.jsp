<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/19/2025
  Time: 7:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Novo Animal</title>
</head>
<body>

<h2>Adicionar Animal</h2>

<%
  String erro = (String) request.getAttribute("erro");
  if (erro != null) {
%>
<p style="color:red;"><%= erro %></p>
<%
  }
  String nif = (String) request.getAttribute("nif");
%>

<p><b>NIF do Tutor:</b> <%= nif == null ? "" : nif %></p>

<form method="post"
      action="<%= request.getContextPath() %>/rececionista/animal/novo"
      enctype="multipart/form-data">

  <input type="hidden" name="nif" value="<%= nif == null ? "" : nif %>"/>

  <label>Nome:</label><br/>
  <input type="text" name="nome" required /><br/><br/>

  <label>Raça:</label><br/>
  <input type="text" name="raca" /><br/><br/>

  <label>Sexo:</label><br/>
  <select name="sexo">
    <option value="">--</option>
    <option value="M">M</option>
    <option value="F">F</option>
  </select><br/><br/>

  <label>Data de Nascimento:</label><br/>
  <input type="date" name="dataNascimento" /><br/><br/>

  <label>Filiação:</label><br/>
  <input type="text" name="filiacao" /><br/><br/>

  <label>Estado Reprodutivo:</label><br/>
  <input type="text" name="estadoReprodutivo" /><br/><br/>

  <label>Alergia:</label><br/>
  <input type="text" name="alergia" /><br/><br/>

  <label>Cor:</label><br/>
  <input type="text" name="cor" /><br/><br/>

  <label>Peso (kg):</label><br/>
  <input type="text" name="peso" /><br/><br/>

  <label>Características distintivas:</label><br/>
  <input type="text" name="distintivas" /><br/><br/>

  <label>Nº Chip:</label><br/>
  <input type="text" name="numChip" /><br/><br/>

  <label>Fotografia (jpg/png/webp):</label><br/>
  <input type="file" name="fotografia" accept=".jpg,.jpeg,.png,.webp" /><br/><br/>

  <button type="submit">Guardar</button>
  <a href="<%= request.getContextPath() %>/animais?nif=<%= nif %>">Cancelar</a>
</form>

</body>
</html>

