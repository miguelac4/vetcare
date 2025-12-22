package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.UserDao;

import java.io.IOException;

@WebServlet("/gerente/utilizadores/veterinarios")
public class ListarVeterinariosServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"gerente".equals(role)) { response.sendError(403); return; }

        request.setAttribute("veterinarios", userDao.findByRole("veterinario")); // <- confirma o texto do role
        request.getRequestDispatcher("/gerente/veterinarios.jsp").forward(request, response);
    }
}
