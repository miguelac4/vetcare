package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;
import org.example.vetcare.dao.ClinicaDao;
import org.example.vetcare.dao.ServicoDao;
import org.example.vetcare.model.Agendamento;
import org.example.vetcare.model.Servico;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/rececionista/agendamento/reagendar")
public class ReagendamentoServlet extends HttpServlet {

    private final AgendamentoDao agDao = new AgendamentoDao();
    private final ServicoDao servicoDao = new ServicoDao();
    private final ClinicaDao clinicaDao = new ClinicaDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Agendamento ag = agDao.findById(id);
        if (ag == null) {
            response.sendError(404);
            return;
        }

        request.setAttribute("agendamento", ag);
        request.setAttribute("servicos", servicoDao.findAll());
        request.setAttribute("clinicas", clinicaDao.findAll());

        request.getRequestDispatcher("/rececionista/reagendamento.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idStr = request.getParameter("idAgendamento");
        String dataHoraStr = request.getParameter("dataHora");     // "2025-12-03T12:30"
        String localidade = request.getParameter("localidade");
        String idServicoStr = request.getParameter("idServico");

        System.out.println("POST reagendar -> idAgendamento=" + idStr +
                " dataHora=" + dataHoraStr +
                " localidade=" + localidade +
                " idServico=" + idServicoStr);

        if (idStr == null || idStr.isBlank() ||
                dataHoraStr == null || dataHoraStr.isBlank() ||
                localidade == null || localidade.isBlank() ||
                idServicoStr == null || idServicoStr.isBlank()) {
            response.sendError(400, "Dados em falta");
            return;
        }

        int idAgendamento = Integer.parseInt(idStr);
        int idServico = Integer.parseInt(idServicoStr);

        java.time.LocalDateTime novaDataHora;
        try {
            novaDataHora = java.time.LocalDateTime.parse(dataHoraStr);
        } catch (Exception e) {
            response.sendError(400, "dataHora inválida (formato esperado: yyyy-MM-ddTHH:mm)");
            return;
        }

        int rows = agDao.reagendar(idAgendamento, novaDataHora, localidade.trim(), idServico);

        if (rows == 0) {
            response.sendError(404, "Agendamento não encontrado (id=" + idAgendamento + ")");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/rececionista/agendamentos");
    }

}
