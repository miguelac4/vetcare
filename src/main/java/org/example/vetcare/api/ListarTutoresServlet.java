package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.model.Cliente;

import java.io.IOException;
import java.util.List;

@WebServlet("/utilizadores/tutores")
public class ListarTutoresServlet extends HttpServlet {

    private final ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }

        boolean allowed = "rececionista".equals(role) || "gerente".equals(role);
        if (!allowed) { response.sendError(403); return; }

        List<Cliente> clientes = clienteDao.findAllClients();
        request.setAttribute("clientes", clientes);

        // escolhe JSP conforme role
        String view = "gerente".equals(role)
                ? "/gerente/tutores.jsp"
                : "/rececionista/tutores.jsp";

        request.getRequestDispatcher(view).forward(request, response);
    }
}
