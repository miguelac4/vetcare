package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/listarAnimais")
public class ListarAnimaisServlet extends HttpServlet {

    private static final String URL  =
            "jdbc:mysql://localhost:3306/vetCare";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // força o carregamento do driver MySQL
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Driver MySQL não encontrado", e);
        }

        List<Animal> animais = new ArrayList<>();

        String sql = "SELECT idAnimal, nome, raca, sexo FROM Animal";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id      = rs.getInt("idAnimal");
                String nome = rs.getString("nome");
                String raca = rs.getString("raca");
                String sexo = rs.getString("sexo");

                animais.add(new Animal(id, nome, raca, sexo));
            }

        } catch (SQLException e) {
            throw new ServletException("Erro ao listar animais", e);
        }

        request.setAttribute("animais", animais);
        request.getRequestDispatcher("/listarAnimais.jsp")
                .forward(request, response);
    }

}
