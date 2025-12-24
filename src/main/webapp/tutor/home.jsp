<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>VetCare — Tutor</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
    <span class="logo">🐾 vetCare</span>

    <nav class="nav">
        <a href="#">Home</a>
        <a href="<%= request.getContextPath() %>/logout" class="nav-logout">Sair</a>
    </nav>
</header>

<main class="content">
    <section class="page-head">
        <div>
            <h1>Home — Tutor</h1>
            <p class="muted">Gestão dos seus animais e marcações</p>
        </div>
    </section>

    <section class="panel">
        <div class="panel-head">
            <h2>As minhas opções</h2>
            <p class="muted">Acesso rápido</p>
        </div>

        <div class="actions">
            <a class="btn btn-primary"
               href="<%= request.getContextPath() %>/animais">
                Os meus animais
            </a>

            <a class="btn btn-secondary"
               href="<%= request.getContextPath() %>/tutor/agendamentos">
                Marcações
            </a>
        </div>
    </section>
</main>

<footer class="footer">
    © 2025 VetCare — Sistema de Gestão
</footer>
</body>
</html>
