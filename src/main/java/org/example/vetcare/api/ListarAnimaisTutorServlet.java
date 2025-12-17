package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.model.Animal;

import java.io.IOException;
import java.util.List;

@WebServlet("/animais")
public class ListarAnimaisTutorServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nif = request.getParameter("nif");
        if (nif == null || nif.isBlank()) {
            response.sendError(400, "NIF em falta.");
            return;
        }

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) {
            response.sendError(401);
            return;
        }

        // apenas roles permitidas
        if (!role.equals("rececionista") && !role.equals("veterinario")) {
            response.sendError(403);
            return;
        }

        request.setAttribute("nif", nif.trim());
        request.setAttribute("animais", animalDao.findAllByNif(nif.trim()));

        // escolhe a view conforme a área
        String jsp = role.equals("rececionista")
                ? "/rececionista/animaisTutor.jsp"
                : "/veterinario/animaisTutor.jsp";

        request.getRequestDispatcher(jsp).forward(request, response);
    }
}

