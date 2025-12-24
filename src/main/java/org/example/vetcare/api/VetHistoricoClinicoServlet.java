package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.HistoricoClinicoDao;
import org.example.vetcare.dao.VeterinarioDao;

import java.io.IOException;

@WebServlet("/veterinario/historico-clinico")
public class VetHistoricoClinicoServlet extends HttpServlet {

    private final HistoricoClinicoDao historicoDao = new HistoricoClinicoDao();
    private final VeterinarioDao veterinarioDao = new VeterinarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"veterinario".equals(role)) { response.sendError(403); return; }

        String idStr = request.getParameter("idAnimal");
        if (idStr == null || idStr.isBlank()) {
            response.sendError(400, "idAnimal em falta.");
            return;
        }

        int idAnimal;
        try {
            idAnimal = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(400, "idAnimal inválido.");
            return;
        }

        request.setAttribute("idAnimal", idAnimal);
        request.setAttribute("historico", historicoDao.findByAnimal(idAnimal)); // se tiveres este método
        request.getRequestDispatcher("/veterinario/historicoClinico.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"veterinario".equals(role)) { response.sendError(403); return; }

        String idStr = request.getParameter("idAnimal");
        String descricao = request.getParameter("descricao");

        if (idStr == null || idStr.isBlank()) {
            response.sendError(400, "idAnimal em falta.");
            return;
        }
        if (descricao == null || descricao.isBlank()) {
            request.setAttribute("erro", "A descrição é obrigatória.");
            doGet(request, response);
            return;
        }

        int idAnimal;
        try {
            idAnimal = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(400, "idAnimal inválido.");
            return;
        }

        String email = (String) session.getAttribute("userEmail");
        if (email == null || email.isBlank()) {
            response.sendError(400, "Email em falta na sessão.");
            return;
        }

        String numLicenca = veterinarioDao.findNumLicencaByEmail(email.trim());
        if (numLicenca == null || numLicenca.isBlank()) {
            response.sendError(400, "Veterinário não encontrado para o email: " + email);
            return;
        }

        int rows = historicoDao.insert(idAnimal, numLicenca, descricao.trim());

        String base = request.getContextPath() + "/veterinario/historico-clinico?idAnimal=" + idAnimal;
        if (rows == 1) {
            response.sendRedirect(base + "&ok=1");
        } else {
            response.sendRedirect(base + "&erro=1");
        }
    }
}
