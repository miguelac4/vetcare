<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 11/29/2025
  Time: 11:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Animal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Animais</title>
</head>
<body>
<h1>Lista de Animais</h1>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Raça</th>
        <th>Sexo</th>
    </tr>

    <%
        List<Animal> animais = (List<Animal>) request.getAttribute("animais");
        if (animais != null) {
            for (Animal a : animais) {
    %>
    <tr>
        <td><%= a.getIdAnimal() %></td>
        <td><%= a.getNome() %></td>
        <td><%= a.getRaca() %></td>
        <td><%= a.getSexo() %></td>
    </tr>
    <%
            }
        }
    %>
</table>

</body>
</html>