<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/17/2025
  Time: 10:27 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  String nome = (String) session.getAttribute("userNome");
  String role = (String) session.getAttribute("userRole");

  String roleLabel = role;
  if ("gerente".equals(role)) roleLabel = "Gerente";
  else if ("veterinario".equals(role)) roleLabel = "Veterinário";
  else if ("tutor".equals(role)) roleLabel = "Tutor";
  else if ("rececionista".equals(role)) roleLabel = "Rececionista";
%>

<%
  String ctx = request.getContextPath();
%>


<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>VetCare — Procurar Tutor</title>
    <link rel="stylesheet" href="<%= ctx %>/css/main.css">
</head>

<body>
<header class="topbar">
    <a class="logo" href="<%= ctx %>/veterinario/home.jsp">🐾 vetCare</a>

    <nav class="nav">
      <a href="<%= ctx %>/veterinario/home.jsp">Home</a>
      <a href="<%= ctx %>/veterinario/agendamentos/sem-veterinario">Sem veterinário</a>
      <a class="nav-logout" href="<%= ctx %>/logout">Sair</a>
    </nav>
    <div class="user-badge">
      <span class="role-pill"><%= roleLabel %></span>
    </div>

</header>

<main class="content">

    <section class="page-head">
        <div>
            <h1>Procurar Tutor</h1>
            <p class="muted">Escreve o nome para pesquisar e selecionar um tutor</p>
        </div>

        <div class="page-actions">
            <a class="btn btn-secondary" href="<%= ctx %>/veterinario/home.jsp">Voltar</a>
        </div>
    </section>

    <section class="panel" style="max-width: 720px;">
        <div class="panel-head">
            <h2>Pesquisa</h2>
            <p class="muted">O sistema sugere tutores à medida que escreves</p>
        </div>

        <div class="autocomplete">
            <label style="font-weight:800;">Nome do tutor</label>
            <input id="nomeTutor" class="input" type="text" autocomplete="off" placeholder="Ex: Ricardo Santos" />
            <input id="nifTutor" type="hidden" />
            <div id="sugestoes" class="autocomplete-list" style="display:none;"></div>
        </div>

        <div class="panel" style="margin-top:12px; box-shadow:none; background:#fff; border:1px dashed var(--border);">
            <p id="selecionado" class="muted" style="margin:0;">Nenhum tutor selecionado.</p>
        </div>
    </section>

</main>

<footer class="footer">
    © 2025 VetCare — Sistema de Gestão
</footer>

<script>
    const input = document.getElementById("nomeTutor");
    const nifHidden = document.getElementById("nifTutor");
    const sugestoesDiv = document.getElementById("sugestoes");
    const selecionado = document.getElementById("selecionado");

    let timer = null;

    input.addEventListener("input", () => {
        clearTimeout(timer);
        const q = input.value.trim();

        if (q.length < 2) {
            sugestoesDiv.style.display = "none";
            sugestoesDiv.innerHTML = "";
            return;
        }

        timer = setTimeout(async () => {
            const url = "<%= ctx %>/veterinario/autocomplete-tutores?q=" + encodeURIComponent(q);
            const res = await fetch(url);
            const data = await res.json();

            sugestoesDiv.innerHTML = "";
            if (!data || data.length === 0) {
                sugestoesDiv.style.display = "none";
                return;
            }

            data.forEach(t => {
                const div = document.createElement("div");
                div.className = "autocomplete-item";
                div.textContent = t.nome + " (" + t.email + ")";
                div.onclick = () => {
                    input.value = t.nome;
                    nifHidden.value = t.nif;
                    sugestoesDiv.style.display = "none";
                    selecionado.innerHTML = "Selecionado: <b>" + t.nome + "</b> | NIF: " + t.nif;
                    window.location.href = "<%= ctx %>/animais?nif=" + encodeURIComponent(t.nif);
                };
                sugestoesDiv.appendChild(div);
            });

            sugestoesDiv.style.display = "block";
        }, 250);
    });

    document.addEventListener("click", (e) => {
        if (!sugestoesDiv.contains(e.target) && e.target !== input) {
            sugestoesDiv.style.display = "none";
        }
    });
</script>

</body>
</html>
