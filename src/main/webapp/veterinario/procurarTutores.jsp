<%--
  Created by IntelliJ IDEA.
  User: Miguel Cordeiro
  Date: 12/17/2025
  Time: 10:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Procurar Tutor</title>
    <style>
        .box { position: relative; width: 320px; }
        .sugestoes { position:absolute; left:0; right:0; border:1px solid #ccc; background:#fff; }
        .item { padding:6px; cursor:pointer; }
        .item:hover { background:#eee; }
    </style>
</head>
<body>

<h2>Procurar Tutor</h2>

<a href="<%= request.getContextPath() %>/veterinario/home.jsp">Voltar</a>
| <a href="<%= request.getContextPath() %>/logout">Logout</a>

<hr/>

<div class="box">
    <label>Nome do tutor:</label><br/>
    <input id="nomeTutor" type="text" autocomplete="off" />
    <input id="nifTutor" type="hidden" />

    <div id="sugestoes" class="sugestoes" style="display:none;"></div>
</div>

<p id="selecionado"></p>

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
            const url = "<%= request.getContextPath() %>/veterinario/autocomplete-tutores?q=" + encodeURIComponent(q);
            const res = await fetch(url);
            const data = await res.json();

            sugestoesDiv.innerHTML = "";
            if (!data || data.length === 0) {
                sugestoesDiv.style.display = "none";
                return;
            }

            data.forEach(t => {
                const div = document.createElement("div");
                div.className = "item";
                div.textContent = t.nome + " (" + t.email + ")";
                div.onclick = () => {
                    input.value = t.nome;
                    nifHidden.value = t.nif;
                    sugestoesDiv.style.display = "none";
                    selecionado.innerHTML = "Selecionado: <b>" + t.nome + "</b> | NIF: " + t.nif;
                    window.location.href = "<%= request.getContextPath() %>/animais?nif=" + encodeURIComponent(t.nif);

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
