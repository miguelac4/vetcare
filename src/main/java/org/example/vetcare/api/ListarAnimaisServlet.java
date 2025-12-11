package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.model.Animal;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/listarAnimais")
public class ListarAnimaisServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Animal> animais = animalDao.findAll();

            request.setAttribute("animais", animais);
            request.getRequestDispatcher("/listarAnimais.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao listar animais", e);
        }
    }
}
