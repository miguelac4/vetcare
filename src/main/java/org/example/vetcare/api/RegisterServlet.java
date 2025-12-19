package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.config.PasswordUtil;
import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.dao.UserDao;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();
    private final ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String nif = request.getParameter("nif");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String telefone = request.getParameter("telefone");
        String morada = request.getParameter("morada");

        if (nome == null || nif == null || email == null || password == null
                || nome.isBlank() || nif.isBlank() || email.isBlank() || password.isBlank()) {
            request.setAttribute("erro", "Preenche nome, nif, email e password.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        nome = nome.trim();
        nif = nif.trim();
        email = email.trim().toLowerCase();

        // validação simples (podes reforçar depois)
        if (!nif.matches("\\d{9}")) {
            request.setAttribute("erro", "NIF inválido. Deve ter 9 dígitos.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // evitar duplicados
        if (userDao.existsByEmail(email) || clienteDao.existsByEmail(email)) {
            request.setAttribute("erro", "Já existe uma conta com este email.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (clienteDao.existsByNif(nif)) {
            request.setAttribute("erro", "Já existe um cliente com este NIF.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            // 1) criar cliente
            clienteDao.insertCliente(nif, nome, email, telefone, morada);

            // 2) criar utilizador (login)
            String hash = PasswordUtil.sha256Hex(password);
            userDao.insertTutorUser(nome, email, hash);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao criar conta. Tenta novamente.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // ir para login com sucesso
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
