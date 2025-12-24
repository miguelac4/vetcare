<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/12/2025
  Time: 2:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>vetCare — Login</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
  <header class="topbar">
    <a class="logo" href="<%= request.getContextPath() %>/index.jsp">🐾 vetCare</a>
  </header>

  <main class="content">
    <section class="panel" style="max-width: 520px; margin: 40px auto;">
      <div class="panel-head">
        <h1>Login</h1>
        <p class="muted">Acede à tua conta VetCare</p>
      </div>

      <%
        String erro = (String) request.getAttribute("erro");
        if (erro != null) {
      %>
        <div class="panel" style="border-color:#ffd6d6; background:#fff5f5; box-shadow:none; margin-top:10px;">
          <p style="margin:0; font-weight:800; color:#c92a2a;"><%= erro %></p>
        </div>
      <%
        }
      %>

      <form method="post" action="<%= request.getContextPath() %>/login" class="panel" style="box-shadow:none; border:none; padding:0; margin-top: 14px;">
        <div style="display:grid; gap:10px;">
          <label style="font-weight:800;">Email</label>
          <input class="input" type="email" name="email" required>

          <label style="font-weight:800; margin-top:8px;">Password</label>
          <input class="input" type="password" name="password" required>

          <button class="btn btn-primary" type="submit" style="margin-top: 10px;">
            Entrar
          </button>

          <p class="muted" style="margin-top: 10px;">
            Ainda não criaste conta?
            <a href="<%= request.getContextPath() %>/register" class="link">Create an Account</a>
          </p>
        </div>
      </form>
    </section>
  </main>

  <footer class="footer">
    © 2025 VetCare — Sistema de Gestão
  </footer>
</body>
</html>

