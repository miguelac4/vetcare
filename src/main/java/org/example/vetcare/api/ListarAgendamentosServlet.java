package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AgendamentoDao;
import org.example.vetcare.model.Agendamento;

import java.io.IOException;
import java.util.List;

@WebServlet("/rececionista/agendamentos")
public class ListarAgendamentosServlet extends HttpServlet {

    private final AgendamentoDao agendamentoDao = new AgendamentoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Agendamento> agendamentos = agendamentoDao.findAll();
        request.setAttribute("agendamentos", agendamentos);

        request.getRequestDispatcher("/rececionista/agendamentos.jsp").forward(request, response);
    }
}
