package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AnimalDao;

import java.io.IOException;

@WebServlet("/gerente/animais")
public class ListarAnimaisGerenteServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) { response.sendError(401); return; }
        if (!"gerente".equals(role)) { response.sendError(403); return; }

        request.setAttribute("animais", animalDao.findAll());
        request.getRequestDispatcher("/gerente/animais.jsp").forward(request, response);
    }
}
