<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/19/2025
  Time: 6:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare - Registo</title>
  <link rel="stylesheet" href="<% =request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/index.jsp">🐾 vetCare</a>
</header>

<main class="content">
  <section class="panel" style="max-width: 620px; margin: 40px auto;">
    <div class="panel-head">
      <h1>Criar Conta(Tutor)</h1>
      <p class="muted">Registo do tutor</p>
    </div>

    <%
      String erro = (String) request.getAttribute("erro");
      if (erro != null) {
    %>
      <div class="panel" style="border-color:#ffd6d6; background:#fff5f5; box-shadow:none; margin-top:10px;>
        <p style="margin:0; font-weight:800; color:#c92a2a;"><%= erro %></p>
      </div>
    <%
    }
    %>

    <form method="post" action="<%= request.getContextPath() %>/register"
        class="panel" style="box-shadow:none; border:none; padding:0; margin-top:14px;">

      <div style="display:grid; gap:10px;">
        <label style="font-weight:800;">Nome</label>
        <input class="input" type="text" name="nome" required>

        <label style="font-weight:800; margin-top:8px;">NIF</label>
        <input class="input" type="text" name="nif" required>

        <label style="font-weight:800; margin-top:8px;">Email</label>
        <input class="input" type="email" name="email" required>

        <label style="font-weight:800; margin-top:8px;">Password</label>
        <input class="input" type="password" name="password" required>

        <label style="font-weight:800; margin-top:8px;">Telefone (opcional)</label>
        <input class="input" type="text" name="telefone">

        <label style="font-weight:800; margin-top:8px;">Morada (opcional)</label>
        <input class="input" type="text" name="morada">

        <button class="btn btn-primary" type="submit" style="margin-top: 10px;">
          Registar
        </button>

        <p class="muted" style="margin-top: 10px;">
          Já tens conta?
          <a href="<%= request.getContextPath() %>/login" class="link">Login</a>
        </p>
      </div>
    </form>
  </section>
</main>

<footer class="footer">
  @ 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>

