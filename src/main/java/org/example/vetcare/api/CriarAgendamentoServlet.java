package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.*;
import org.example.vetcare.model.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/rececionista/agendamento/criar")
public class CriarAgendamentoServlet extends HttpServlet {

    private final AgendamentoDao agDao = new AgendamentoDao();
    private final ServicoDao servicoDao = new ServicoDao();
    private final ClinicaDao clinicaDao = new ClinicaDao();
    private final AnimalDao animalDao = new AnimalDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Servico> servicos = servicoDao.findAll();
        List<Clinica> clinicas = clinicaDao.findAll();
        List<Animal> animais = animalDao.findAll();

        request.setAttribute("servicos", servicos);
        request.setAttribute("clinicas", clinicas);
        request.setAttribute("animais", animais);

        request.getRequestDispatcher("/rececionista/criarAgendamento.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String dataHoraStr = request.getParameter("dataHora");   // yyyy-MM-ddTHH:mm
        String localidade = request.getParameter("localidade");
        String idServicoStr = request.getParameter("idServico");
        String idAnimalStr = request.getParameter("idAnimal");

        if (dataHoraStr == null || dataHoraStr.isBlank() ||
                localidade == null || localidade.isBlank() ||
                idServicoStr == null || idServicoStr.isBlank() ||
                idAnimalStr == null || idAnimalStr.isBlank()) {
            response.sendError(400, "Dados em falta");
            return;
        }

        LocalDateTime dataHora = LocalDateTime.parse(dataHoraStr);
        int idServico = Integer.parseInt(idServicoStr);
        int idAnimal = Integer.parseInt(idAnimalStr);

        agDao.insert(dataHora, "marcado", "rececionista", localidade.trim(), idServico, idAnimal);

        response.sendRedirect(request.getContextPath() + "/rececionista/agendamentos");
    }
}
