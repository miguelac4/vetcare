package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;
import org.example.vetcare.dao.VeterinarioDao;

import java.io.IOException;

@WebServlet("/veterinario/agendamentos/assumir")
public class VetAgendarServlet extends HttpServlet {

    private final AgendamentoDao agendamentoDao = new AgendamentoDao();
    private final VeterinarioDao veterinarioDao = new VeterinarioDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"veterinario".equals(role)) { response.sendError(403); return; }

        String email = (String) session.getAttribute("userEmail");
        if (email == null || email.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Email em falta na sessão.");
            return;
        }

        String idStr = request.getParameter("idAgendamento");
        if (idStr == null || idStr.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "idAgendamento em falta.");
            return;
        }

        int idAgendamento;
        try {
            idAgendamento = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "idAgendamento inválido.");
            return;
        }

        String numLicenca = veterinarioDao.findNumLicencaByEmail(email.trim());
        if (numLicenca == null || numLicenca.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Veterinário não encontrado para o email: " + email);
            return;
        }

        int updated = agendamentoDao.assignVeterinarioIfNull(idAgendamento, numLicenca);


        // volta para a lista com uma mensagem simples
        String base = request.getContextPath() + "/veterinario/agendamentos/sem-veterinario";
        if (updated == 1) {
            response.sendRedirect(base + "?ok=1");
        } else {
            // alguém já assumiu antes
            response.sendRedirect(base + "?erro=ja_atribuido");
        }
    }
}
