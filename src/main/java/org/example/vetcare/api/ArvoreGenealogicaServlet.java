package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.model.Animal;

import java.io.IOException;

@WebServlet("/veterinario/animal/arvore")
public class ArvoreGenealogicaServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // (opcional) só veterinário
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

        Animal pai = (animal.getIdPai() == null) ? null : animalDao.findById(animal.getIdPai());
        Animal mae = (animal.getIdMae() == null) ? null : animalDao.findById(animal.getIdMae());

        Animal avoPaterno = (pai == null || pai.getIdPai() == null) ? null : animalDao.findById(pai.getIdPai());
        Animal avoPaterna = (pai == null || pai.getIdMae() == null) ? null : animalDao.findById(pai.getIdMae());

        Animal avoMaterno = (mae == null || mae.getIdPai() == null) ? null : animalDao.findById(mae.getIdPai());
        Animal avoMaterna = (mae == null || mae.getIdMae() == null) ? null : animalDao.findById(mae.getIdMae());

        request.setAttribute("animal", animal);
        request.setAttribute("pai", pai);
        request.setAttribute("mae", mae);

        request.setAttribute("avoPaterno", avoPaterno);
        request.setAttribute("avoPaterna", avoPaterna);
        request.setAttribute("avoMaterno", avoMaterno);
        request.setAttribute("avoMaterna", avoMaterna);

        request.getRequestDispatcher("/veterinario/arvoreGenealogica.jsp").forward(request, response);
    }
}
