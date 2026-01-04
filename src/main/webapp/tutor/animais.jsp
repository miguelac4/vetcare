<%--
  Os meus animais — Tutor
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.vetcare.model.Animal" %>

<%
    String nif = (String) request.getAttribute("nif");
    List<Animal> animais = (List<Animal>) request.getAttribute("animais");
%>

<%
  String nome = (String) session.getAttribute("userNome");
  String role = (String) session.getAttribute("userRole");

  String roleLabel = role;
  if ("gerente".equals(role)) roleLabel = "Gerente";
  else if ("veterinario".equals(role)) roleLabel = "Veterinário";
  else if ("tutor".equals(role)) roleLabel = "Tutor";
  else if ("rececionista".equals(role)) roleLabel = "Rececionista";
%>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>vetCare — Os meus animais</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>

<body>
<header class="topbar">
    <a class="logo" href="<%= request.getContextPath() %>/tutor/home.jsp">🐾 vetCare</a>

    <nav class="nav">
        <a href="<%= request.getContextPath() %>/tutor/home.jsp">Home</a>
        <a href="<%= request.getContextPath() %>/animais">Animais</a>
        <a href="<%= request.getContextPath() %>/tutor/agendamentos">Marcações</a>
        <a class="nav-logout" href="<%= request.getContextPath() %>/logout">Sair</a>
    </nav>

    <div class="user-badge">
        <span class="role-pill"><%= roleLabel %></span>
    </div>

</header>

<main class="content">
    <section class="page-head">
        <div>
            <h1>Os meus animais</h1>
            <p class="muted">Lista de animais associados ao teu NIF</p>
        </div>
    </section>

    <section class="panel">
        <div class="panel-head">
            <h2>Registos</h2>
            <p class="muted">
                <b>NIF:</b> <%= nif == null ? "" : nif %>
            </p>
        </div>

        <%
            if (animais == null || animais.isEmpty()) {
        %>
            <p class="muted">Não tens animais registados.</p>
        <%
            } else {
        %>
        <div class="table-wrap">
            <table class="table table-wide">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Raça</th>
                    <th>Sexo</th>
                    <th>Data Nascimento</th>
                    <th>Estado Reprodutivo</th>
                    <th>Alergia</th>
                    <th>Cor</th>
                    <th>Peso</th>
                    <th>Distintivas</th>
                    <th>Nº Chip</th>
                    <th class="col-actions">Fotografia</th>
                </tr>
                </thead>

                <tbody>
                <%
                    for (Animal a : animais) {
                        String foto = a.getFotografia();
                %>
                <tr>
                    <td data-label="ID"><%= a.getIdAnimal() %></td>
                    <td data-label="Nome"><%= a.getNome() %></td>
                    <td data-label="Raça"><%= a.getRaca() == null ? "" : a.getRaca() %></td>
                    <td data-label="Sexo"><%= a.getSexo() == null ? "" : a.getSexo() %></td>
                    <td data-label="Data Nascimento"><%= a.getDataNascimento() == null ? "" : a.getDataNascimento() %></td>
                    <td data-label="Estado Reprodutivo"><%= a.getEstadoReprodutivo() == null ? "" : a.getEstadoReprodutivo() %></td>
                    <td data-label="Alergia"><%= a.getAlergia() == null ? "" : a.getAlergia() %></td>
                    <td data-label="Cor"><%= a.getCor() == null ? "" : a.getCor() %></td>
                    <td data-label="Peso"><%= a.getPeso() == null ? "" : a.getPeso() %></td>
                    <td data-label="Distintivas"><%= a.getDistintivas() == null ? "" : a.getDistintivas() %></td>
                    <td data-label="Nº Chip"><%= a.getNumChip() == null ? "" : a.getNumChip() %></td>

                    <td data-label="Fotografia" class="td-actions">
                        <%
                            if (foto != null && !foto.isBlank()) {
                        %>
                            <a class="btn btn-secondary btn-sm"
                               href="<%= request.getContextPath() + foto %>" target="_blank" rel="noopener">
                                Ver
                            </a>
                        <%
                            } else {
                        %>
                            <span class="muted">-</span>
                        <%
                            }
                        %>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <%
                }
            %>
        </div>
    </section>
</main>

<footer class="footer">
    © 2025 VetCare — Sistema de Gestão
</footer>

</body>
</html>
