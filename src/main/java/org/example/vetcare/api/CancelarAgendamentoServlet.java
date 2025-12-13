package org.example.vetcare.api;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.vetcare.dao.AgendamentoDao;

import java.io.IOException;

@WebServlet("/rececionista/agendamento/cancelar")
public class CancelarAgendamentoServlet extends HttpServlet {

    private final AgendamentoDao dao = new AgendamentoDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idStr = request.getParameter("idAgendamento");
        if (idStr == null) {
            response.sendError(400);
            return;
        }

        int id = Integer.parseInt(idStr);
        dao.updateEstado(id, "cancelado");

        response.sendRedirect(request.getContextPath() + "/rececionista/agendamentos");
    }
}
