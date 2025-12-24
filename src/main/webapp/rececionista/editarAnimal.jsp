<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Animal" %>
<%@ page import="org.example.vetcare.model.Taxonomia" %>

<%
  Animal a = (Animal) request.getAttribute("animal");
  if (a == null) {
%>
<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Editar Animal</title>
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
  <section class="panel">
    <div class="panel-head">
      <h1>Animal não encontrado</h1>
      <p class="muted">O registo pedido não existe ou não foi carregado.</p>
    </div>

    <div class="actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/rececionista/tutores">← Voltar</a>
    </div>
  </section>
</main>

<footer class="footer">© 2025 VetCare — Sistema de Gestão</footer>
</body>
</html>
<%
    return;
  }

  List<Animal> animaisDoTutor = (List<Animal>) request.getAttribute("animaisDoTutor");
  List<Taxonomia> taxonomias = (List<Taxonomia>) request.getAttribute("taxonomias");
  String dataNasc = (a.getDataNascimento() == null) ? "" : a.getDataNascimento().toString();
%>

<!DOCTYPE html>
<html lang="pt">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>VetCare — Editar Animal</title>
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
      <h1>Editar Animal</h1>
      <p class="muted">
        ID: <strong><%= a.getIdAnimal() %></strong>
        · Tutor (NIF): <strong><%= a.getNif() == null ? "" : a.getNif() %></strong>
      </p>
    </div>

    <div class="page-actions">
      <a class="btn btn-secondary" href="<%= request.getContextPath() %>/animais?nif=<%= a.getNif() %>">← Voltar</a>
    </div>
  </section>

  <section class="panel">
    <div class="panel-head">
      <h2>Dados do Animal</h2>
      <p class="muted">Altera os campos necessários e guarda</p>
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
          action="<%= request.getContextPath() %>/rececionista/animal/editar"
          enctype="multipart/form-data"
          style="margin-top:14px;">

      <!-- chaves/ids -->
      <input type="hidden" name="idAnimal" value="<%= a.getIdAnimal() %>"/>
      <input type="hidden" name="nif" value="<%= a.getNif() %>"/>

      <div style="display:grid; gap:12px; max-width: 900px;">

        <div>
          <label style="font-weight:900;">Nome</label>
          <input class="input" type="text" name="nome"
                 value="<%= a.getNome() == null ? "" : a.getNome() %>"
                 maxlength="20" required />
        </div>

        <div>
          <label style="font-weight:900;">Raça</label>
          <input class="input" type="text" name="raca"
                 value="<%= a.getRaca() == null ? "" : a.getRaca() %>"
                 maxlength="20" />
        </div>

        <div>
          <label style="font-weight:900;">Sexo</label>
          <select class="input" name="sexo" required>
            <option value="">-- selecionar --</option>
            <option value="M" <%= "M".equals(a.getSexo()) ? "selected" : "" %>>M</option>
            <option value="F" <%= "F".equals(a.getSexo()) ? "selected" : "" %>>F</option>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Data de Nascimento</label>
          <input class="input" type="date" name="dataNascimento" value="<%= dataNasc %>" />
        </div>

        <div>
          <label style="font-weight:900;">Pai</label>
          <select class="input" name="idPai">
            <option value="">-- (desconhecido) --</option>
            <%
              if (animaisDoTutor != null) {
                for (Animal p : animaisDoTutor) {
                  if (p.getSexo() != null && !"M".equalsIgnoreCase(p.getSexo())) continue;
                  if (p.getIdAnimal() == a.getIdAnimal()) continue;

                  String sel = (a.getIdPai() != null && a.getIdPai().intValue() == p.getIdAnimal()) ? "selected" : "";
            %>
              <option value="<%= p.getIdAnimal() %>" <%= sel %>>
                <%= p.getNome() %> (#<%= p.getIdAnimal() %>)
              </option>
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
                for (Animal m : animaisDoTutor) {
                  if (m.getSexo() != null && !"F".equalsIgnoreCase(m.getSexo())) continue;
                  if (m.getIdAnimal() == a.getIdAnimal()) continue;

                  String sel = (a.getIdMae() != null && a.getIdMae().intValue() == m.getIdAnimal()) ? "selected" : "";
            %>
              <option value="<%= m.getIdAnimal() %>" <%= sel %>>
                <%= m.getNome() %> (#<%= m.getIdAnimal() %>)
              </option>
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
                  String racaTx = t.getRaca() == null ? "" : t.getRaca();

                  String labelBase = especie + (racaTx.isBlank() ? "" : " - " + racaTx);

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

                  String sel = (a.getIdTaxonomia() != null && a.getIdTaxonomia().intValue() == t.getIdTaxonomia()) ? "selected" : "";
            %>
              <option value="<%= t.getIdTaxonomia() %>" <%= sel %>><%= labelBase + detalhes + extra %></option>
            <%
                }
              }
            %>
          </select>
        </div>

        <div>
          <label style="font-weight:900;">Estado Reprodutivo</label>
          <input class="input" type="text" name="estadoReprodutivo"
                 value="<%= a.getEstadoReprodutivo() == null ? "" : a.getEstadoReprodutivo() %>"
                 maxlength="12" />
        </div>

        <div>
          <label style="font-weight:900;">Alergia</label>
          <input class="input" type="text" name="alergia"
                 value="<%= a.getAlergia() == null ? "" : a.getAlergia() %>"
                 maxlength="20" />
        </div>

        <div>
          <label style="font-weight:900;">Cor</label>
          <input class="input" type="text" name="cor"
                 value="<%= a.getCor() == null ? "" : a.getCor() %>"
                 maxlength="15" />
        </div>

        <div>
          <label style="font-weight:900;">Peso</label>
          <input class="input" type="number" step="0.01" name="peso"
                 value="<%= a.getPeso() == null ? "" : a.getPeso() %>" />
        </div>

        <div>
          <label style="font-weight:900;">Distintivas</label>
          <input class="input" type="text" name="distintivas"
                 value="<%= a.getDistintivas() == null ? "" : a.getDistintivas() %>"
                 maxlength="30" />
        </div>

        <div>
          <label style="font-weight:900;">Nº Chip</label>
          <input class="input" type="text" name="numChip"
                 value="<%= a.getNumChip() == null ? "" : a.getNumChip() %>"
                 maxlength="15" />
        </div>

        <div>
          <label style="font-weight:900;">Fotografia</label>
          <input class="input" type="file" name="fotografia" accept="image/*" />
          <p class="muted" style="margin-top:8px;">Se não escolheres ficheiro, mantém a fotografia atual.</p>
        </div>

        <div class="actions" style="margin-top:4px;">
          <button class="btn btn-primary" type="submit">Guardar</button>
          <a class="btn btn-secondary" href="<%= request.getContextPath() %>/animais?nif=<%= a.getNif() %>">Cancelar</a>
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
