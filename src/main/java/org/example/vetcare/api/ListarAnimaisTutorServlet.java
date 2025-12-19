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

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");

        if (role == null) {
            response.sendError(401);
            return;
        }

        String nif;

        // TUTOR: nif vem sempre da sessão (NÃO aceitar querystring)
        if (role.equals("tutor")) {
            nif = (String) session.getAttribute("userNif"); // ajusta se o teu atributo tiver outro nome
            if (nif == null || nif.isBlank()) {
                response.sendError(400, "NIF do tutor em falta na sessão.");
                return;
            }

            // STAFF: nif vem do parâmetro
        } else if (role.equals("rececionista") || role.equals("veterinario")) {
            nif = request.getParameter("nif");
            if (nif == null || nif.isBlank()) {
                response.sendError(400, "NIF em falta.");
                return;
            }

        } else {
            response.sendError(403);
            return;
        }

        nif = nif.trim();

        request.setAttribute("nif", nif);
        request.setAttribute("animais", animalDao.findAllByNif(nif));

        // escolhe a view conforme a área
        String jsp;
        if (role.equals("rececionista")) {
            jsp = "/rececionista/animaisTutor.jsp";
        } else if (role.equals("veterinario")) {
            jsp = "/veterinario/animaisTutor.jsp";
        } else { // tutor
            jsp = "/tutor/animais.jsp";
        }

        request.getRequestDispatcher(jsp).forward(request, response);
    }
}
