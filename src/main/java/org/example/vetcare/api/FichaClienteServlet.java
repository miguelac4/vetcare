package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.model.Cliente;

import java.io.IOException;

@WebServlet("/rececionista/ficha-cliente")
public class FichaClienteServlet extends HttpServlet {

    private final ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nif = request.getParameter("nif");

        if (nif == null || nif.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "NIF em falta.");
            return;
        }

        Cliente cliente = clienteDao.findFichaClientByNif(nif.trim());
        if (cliente == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Cliente não encontrado.");
            return;
        }

        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("/rececionista/fichaCliente.jsp").forward(request, response);
    }
}
