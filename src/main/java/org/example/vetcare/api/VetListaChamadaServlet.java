package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;
import org.example.vetcare.dao.VeterinarioDao;

import java.io.IOException;

@WebServlet("/veterinario/lista-chamada")
public class VetListaChamadaServlet extends HttpServlet {

    private final AgendamentoDao agendamentoDao = new AgendamentoDao();
    private final VeterinarioDao veterinarioDao = new VeterinarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        String numLicenca = veterinarioDao.findNumLicencaByEmail(email.trim()); // lembra: devolve String (V1001)
        if (numLicenca == null || numLicenca.isBlank()) {
            response.sendError(400, "Veterinário não encontrado para o email: " + email);
            return;
        }

        request.setAttribute("agendamentos", agendamentoDao.findAgendamentosByNumLicenca(numLicenca));
        request.getRequestDispatcher("/veterinario/listaChamada.jsp").forward(request, response);
    }
}
