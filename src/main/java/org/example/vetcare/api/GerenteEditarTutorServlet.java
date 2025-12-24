package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.model.Cliente;

import java.io.IOException;

@WebServlet("/gerente/tutor/editar")
public class GerenteEditarTutorServlet extends HttpServlet {

    private final ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"gerente".equals(role)) { response.sendError(403); return; }

        String nif = request.getParameter("nif");
        if (nif == null || nif.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "NIF em falta");
            return;
        }

        Cliente cliente = clienteDao.findFichaClientByNif(nif.trim());
        if (cliente == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Cliente não encontrado");
            return;
        }

        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("/gerente/editarTutor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"gerente".equals(role)) { response.sendError(403); return; }

        Cliente c = new Cliente();
        c.setNif(request.getParameter("nif"));
        c.setNome(request.getParameter("nome"));
        c.setSexo(request.getParameter("sexo"));
        c.setTelefone(request.getParameter("telefone"));

        // NÃO alterar email: vem readonly + hidden do JSP
        c.setEmail(request.getParameter("email"));

        c.setMorada(request.getParameter("morada"));
        c.setFreguesia(request.getParameter("freguesia"));
        c.setConcelho(request.getParameter("concelho"));

        String capital = request.getParameter("capitalSocial");
        if (capital != null && !capital.isBlank()) {
            c.setCapitalSocial(Double.parseDouble(capital));
        }

        clienteDao.update(c);

        response.sendRedirect(request.getContextPath() + "/utilizadores/tutores");
    }
}
