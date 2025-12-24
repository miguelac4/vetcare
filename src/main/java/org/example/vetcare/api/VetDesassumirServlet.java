package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;
import org.example.vetcare.dao.VeterinarioDao;

import java.io.IOException;

@WebServlet("/veterinario/agendamentos/desassumir")
public class VetDesassumirServlet extends HttpServlet {

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
            response.sendError(400, "Email em falta na sessão.");
            return;
        }

        String numLicenca = veterinarioDao.findNumLicencaByEmail(email.trim());
        if (numLicenca == null || numLicenca.isBlank()) {
            response.sendError(400, "Veterinário não encontrado para o email: " + email);
            return;
        }

        String idStr = request.getParameter("idAgendamento");
        if (idStr == null || idStr.isBlank()) {
            response.sendError(400, "idAgendamento em falta.");
            return;
        }

        int idAgendamento;
        try {
            idAgendamento = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(400, "idAgendamento inválido.");
            return;
        }

        int updated = agendamentoDao.unassignVeterinario(idAgendamento, numLicenca);

        String base = request.getContextPath() + "/veterinario/lista-chamada";
        if (updated == 1) {
            response.sendRedirect(base + "?ok=desassumido");
        } else {
            response.sendRedirect(base + "?erro=nao_autorizado");
        }
    }
}
