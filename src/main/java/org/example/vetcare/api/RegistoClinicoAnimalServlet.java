package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.dao.TaxonomiaDao;
import org.example.vetcare.model.Animal;
import org.example.vetcare.model.Taxonomia;

import java.io.IOException;

@WebServlet("/veterinario/animal/registro-clinico")
public class RegistoClinicoAnimalServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();
    private final TaxonomiaDao taxonomiaDao = new TaxonomiaDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // segurança básica: só veterinário (ajusta se quiseres também rececionista)
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!"veterinario".equals(role)) { response.sendError(403); return; }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendError(400, "id em falta.");
            return;
        }

        int id;
        try { id = Integer.parseInt(idStr); }
        catch (NumberFormatException e) { response.sendError(400, "id inválido."); return; }

        Animal animal = animalDao.findById(id);
        if (animal == null) {
            response.sendError(404, "Animal não encontrado.");
            return;
        }

        Taxonomia tax = null;
        if (animal.getIdTaxonomia() != null) {
            tax = taxonomiaDao.findById(animal.getIdTaxonomia());
        }

        request.setAttribute("animal", animal);
        request.setAttribute("taxonomia", tax);

        request.getRequestDispatcher("/veterinario/registoClinicoAnimal.jsp").forward(request, response);
    }
}
