package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.model.Animal;

import java.io.IOException;
import java.util.List;

@WebServlet("/rececionista/animais")
public class ListarAnimaisTutorServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nif = request.getParameter("nif");

        if (nif == null || nif.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "NIF em falta.");
            return;
        }

        List<Animal> animais = animalDao.findAllByNif(nif.trim());
        request.setAttribute("nif", nif.trim());
        request.setAttribute("animais", animais);

        request.getRequestDispatcher("/rececionista/animaisTutor.jsp").forward(request, response);
    }
}
