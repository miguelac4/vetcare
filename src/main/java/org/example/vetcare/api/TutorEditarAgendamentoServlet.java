package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;
import org.example.vetcare.model.Agendamento;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/tutor/agendamento/editar")
public class TutorEditarAgendamentoServlet extends HttpServlet {

    private final AgendamentoDao agendamentoDao = new AgendamentoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // (opcional) segurança básica: só tutor
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!"tutor".equals(role)) { response.sendError(403); return; }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "id em falta.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "id inválido.");
            return;
        }

        Agendamento ag = agendamentoDao.findById(id);
        if (ag == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Marcação não encontrada.");
            return;
        }

        request.setAttribute("agendamento", ag);
        request.getRequestDispatcher("/tutor/editarAgendamento.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // (opcional) segurança básica: só tutor
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!"tutor".equals(role)) { response.sendError(403); return; }

        String idStr = request.getParameter("idAgendamento");
        String data = request.getParameter("data");   // YYYY-MM-DD
        String hora = request.getParameter("hora");   // HH:mm
        String localidade = request.getParameter("localidade");
        String idServicoStr = request.getParameter("idServico");

        if (idStr == null || idStr.isBlank() || data == null || data.isBlank() || hora == null || hora.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parâmetros em falta.");
            return;
        }

        int idAgendamento;
        int idServico;
        try {
            idAgendamento = Integer.parseInt(idStr);
            idServico = Integer.parseInt(idServicoStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "IDs inválidos.");
            return;
        }

        if (localidade == null) localidade = "";
        localidade = localidade.trim();

        LocalDateTime novaDataHora;
        try {
            novaDataHora = LocalDateTime.parse(data.trim() + "T" + hora.trim());
        } catch (Exception e) {
            request.setAttribute("erro", "Data/Hora inválidas.");
            request.setAttribute("agendamento", agendamentoDao.findById(idAgendamento));
            request.getRequestDispatcher("/tutor/editarAgendamento.jsp").forward(request, response);
            return;
        }

        int rows = agendamentoDao.reagendar(idAgendamento, novaDataHora, localidade, idServico);
        if (rows <= 0) {
            request.setAttribute("erro", "Não foi possível atualizar a marcação.");
            request.setAttribute("agendamento", agendamentoDao.findById(idAgendamento));
            request.getRequestDispatcher("/tutor/editarAgendamento.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/tutor/agendamentos");
    }
}
