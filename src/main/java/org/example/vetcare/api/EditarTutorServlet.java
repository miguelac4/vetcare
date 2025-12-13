package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.model.Cliente;

import java.io.IOException;

@WebServlet("/rececionista/tutor/editar")
public class EditarTutorServlet extends HttpServlet {

    private final ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nif = request.getParameter("nif");

        if (nif == null || nif.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "NIF em falta");
            return;
        }

        Cliente cliente = clienteDao.findFichaClientByNif(nif);
        if (cliente == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Cliente não encontrado");
            return;
        }

        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("/rececionista/editarTutor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cliente c = new Cliente();
        c.setNif(request.getParameter("nif"));
        c.setNome(request.getParameter("nome"));
        c.setSexo(request.getParameter("sexo"));
        c.setTelefone(request.getParameter("telefone"));
        c.setEmail(request.getParameter("email"));
        c.setMorada(request.getParameter("morada"));
        c.setFreguesia(request.getParameter("freguesia"));
        c.setConcelho(request.getParameter("concelho"));

        String capital = request.getParameter("capitalSocial");
        if (capital != null && !capital.isBlank()) {
            c.setCapitalSocial(Double.parseDouble(capital));
        }

        clienteDao.update(c);

        response.sendRedirect(
                request.getContextPath() + "/rececionista/ficha-cliente?nif=" + c.getNif()
        );
    }
}
