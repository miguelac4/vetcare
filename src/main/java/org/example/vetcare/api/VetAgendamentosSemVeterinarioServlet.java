package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;

import java.io.IOException;

@WebServlet("/veterinario/agendamentos/sem-veterinario")
public class VetAgendamentosSemVeterinarioServlet extends HttpServlet {

    private final AgendamentoDao agendamentoDao = new AgendamentoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // segurança: só veterinário
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!"veterinario".equals(role)) { response.sendError(403); return; }

        request.setAttribute("agendamentos", agendamentoDao.findSemVeterinario());
        request.getRequestDispatcher("/veterinario/agendamentosSemVeterinario.jsp").forward(request, response);
    }
}
