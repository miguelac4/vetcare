package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.model.Cliente;

import java.io.IOException;
import java.util.List;

@WebServlet("/rececionista/tutores")
public class ListarTutoresServlet extends HttpServlet {

    private final ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Cliente> clientes = clienteDao.findAllClients();
        request.setAttribute("clientes", clientes);

        request.getRequestDispatcher("/rececionista/tutores.jsp").forward(request, response);
    }
}
