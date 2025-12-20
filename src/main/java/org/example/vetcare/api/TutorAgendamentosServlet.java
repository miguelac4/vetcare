package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;

import java.io.IOException;

@WebServlet("/tutor/agendamentos")
public class TutorAgendamentosServlet extends HttpServlet {

    private final AgendamentoDao agendamentoDao = new AgendamentoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"tutor".equals(role)) { response.sendError(403); return; }

        // NIF do tutor logado
        String nif = (String) session.getAttribute("userNif");
        if (nif == null || nif.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "NIF do tutor em falta na sessão.");
            return;
        }

        nif = nif.trim();

        request.setAttribute("agendamentos", agendamentoDao.findAgendamentosByNIF(nif));
        request.getRequestDispatcher("/tutor/agendamentos.jsp").forward(request, response);
    }
}
