<%--
  Created by IntelliJ IDEA.
  User: Miguel
  Date: 12/19/2025
  Time: 7:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Animal" %>
<%@ page import="org.example.vetcare.model.Taxonomia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  List<Animal> animaisDoTutor = (List<Animal>) request.getAttribute("animaisDoTutor");
  List<Taxonomia> taxonomias = (List<Taxonomia>) request.getAttribute("taxonomias");
  String nif = (String) request.getAttribute("nif");
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Novo Animal</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
  <a class="logo" href="<%= request.getContextPath() %>/rececionista/home.jsp">🐾 vetCare</a>

  <nav class="nav">
    <a href="<%= request.getContextPath() %>/rececionista/home.jsp">Home</a>
    <a href="<%= request.getContextPath() %>/rececionista/tutores">Tutores</a>
    <a href="<%= request.getContextPath() %>/rececionista/agendamentos">Agendamentos</a>
    <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
  </nav>
</header>

<main class="content">
  <section class="page-head">
    <div>
      <h1>Adicionar Animal</h1>
      <p class="muted">Tutor (NIF): <strong><%= nif == null ? "" : nif %></strong></p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/animais?nif=<%= nif %>">← Voltar</a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Dados do Animal</h2>
      <p class="muted">Preenche o mínimo necessário e guarda</p>
    </div>

    <%
      String erro = (String) request.getAttribute("erro");
      if (erro != null) {
    %>
      <div class="panel" style="border-color:#ffd6d6; background:#fff5f5; box-shadow:none; margin-top:10px;">
        <p style="margin:0; font-weight:900; color:#c92a2a;"><%= erro %></p>
      </div>
    <%
      }
    %>

    <form method="post"
          action="<%= request.getContextPath() %>/rececionista/animal/novo"
          enctype="multipart/form-data"
          style="margin-top:14px;">

      <input type="hidden" name="nif" value="<%= nif == null ? "" : nif %>"/>

      <div style="display:grid; gap:12px; max-width: 820px;">
        <div>
          <label style="font-weight:900;">Nome</label>
          <input class="input" type="text" name="nome" required />
        </div>

        <div>
          <label style="font-weight:900;">Raça</label>
          <input class="input" type="text" name="raca" />
        </div>

        <div>
          <label style="font-weight:900;">Sexo</label>
          <select class="input" name="sexo">
            <option value="">--</option>
            <option value="M">M</option>
            <option value="F">F</option>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Data de Nascimento</label>
          <input class="input" type="date" name="dataNascimento" />
        </div>

        <div>
          <label style="font-weight:900;">Estado Reprodutivo</label>
          <input class="input" type="text" name="estadoReprodutivo" />
        </div>

        <div>
          <label style="font-weight:900;">Alergia</label>
          <input class="input" type="text" name="alergia" />
        </div>

        <div>
          <label style="font-weight:900;">Cor</label>
          <input class="input" type="text" name="cor" />
        </div>

        <div>
          <label style="font-weight:900;">Peso (kg)</label>
          <input class="input" type="text" name="peso" />
        </div>

        <div>
          <label style="font-weight:900;">Características distintivas</label>
          <input class="input" type="text" name="distintivas" />
        </div>

        <div>
          <label style="font-weight:900;">Nº Chip</label>
          <input class="input" type="text" name="numChip" />
        </div>

        <div>
          <label style="font-weight:900;">Pai</label>
          <select class="input" name="idPai">
            <option value="">-- (desconhecido) --</option>
            <%
              if (animaisDoTutor != null) {
                for (Animal an : animaisDoTutor) {
                  if (!"M".equalsIgnoreCase(an.getSexo())) continue;
            %>
              <option value="<%= an.getIdAnimal() %>"><%= an.getNome() %> (#<%= an.getIdAnimal() %>)</option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Mãe</label>
          <select class="input" name="idMae">
            <option value="">-- (desconhecida) --</option>
            <%
              if (animaisDoTutor != null) {
                for (Animal an : animaisDoTutor) {
                  if (!"F".equalsIgnoreCase(an.getSexo())) continue;
            %>
              <option value="<%= an.getIdAnimal() %>"><%= an.getNome() %> (#<%= an.getIdAnimal() %>)</option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Taxonomia</label>
          <select class="input" name="idTaxonomia" required>
            <option value="">-- escolher --</option>
            <%
              if (taxonomias != null) {
                for (Taxonomia t : taxonomias) {

                  String especie = t.getEspecie() == null ? "" : t.getEspecie();
                  String raca = t.getRaca() == null ? "" : t.getRaca();

                  String labelBase = especie + (raca.isBlank() ? "" : " - " + raca);

                  String detalhes =
                          " | " + (t.getPorte() == null ? "-" : t.getPorte()) +
                                  " | " + (t.getRegimeAlimentar() == null ? "-" : t.getRegimeAlimentar()) +
                                  " | vida: " + (t.getExpetativaVida() == null ? "-" : t.getExpetativaVida()) + " anos" +
                                  " | peso: " + (t.getPeso() == null ? "-" : String.format(java.util.Locale.US, "%.2f", t.getPeso())) + " kg" +
                                  " | comp: " + (t.getComprimento() == null ? "-" : String.format(java.util.Locale.US, "%.2f", t.getComprimento())) + " cm";

                  String extra = "";
                  if (t.getPredisposicaoGenetica() != null && !t.getPredisposicaoGenetica().isBlank()) {
                    extra += " | gen: " + t.getPredisposicaoGenetica();
                  }
                  if (t.getCuidadosEspeciais() != null && !t.getCuidadosEspeciais().isBlank()) {
                    extra += " | cuidados: " + t.getCuidadosEspeciais();
                  }
            %>
              <option value="<%= t.getIdTaxonomia() %>"><%= labelBase + detalhes + extra %></option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Fotografia (jpg/png/webp)</label>
          <input class="input" type="file" name="fotografia" accept=".jpg,.jpeg,.png,.webp" />
        </div>

        <div class="actions" style="margin-top:4px;">
          <button class="btn btn-primary" type="submit">Guardar</button>
          <a class="btn btn-secondary" href="<%= request.getContextPath() %>/animais?nif=<%= nif %>">Cancelar</a>
        </div>
      </div>
    </form>
  </section>
</main>

<footer class="footer">
  © 2025 VetCare — Sistema de Gestão
</footer>

</body>
</html>
