package org.example.vetcare.api;

import org.example.vetcare.config.PasswordUtil;
import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.dao.UserDao;
import org.example.vetcare.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();
    private final ClienteDao clienteDao = new ClienteDao();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isBlank() || password.isBlank()) {
            request.setAttribute("erro", "Preenche email e password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        String hash = PasswordUtil.sha256Hex(password);
        User user = userDao.findByEmailAndPasswordHash(email.trim(), hash);

        if (user == null) {
            request.setAttribute("erro", "Credenciais inválidas.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userNome", user.getNome());
        session.setAttribute("userRole", user.getRole());

        if ("tutor".equals(user.getRole())) {
            String nif = clienteDao.findNifByEmail(email.trim());

            if (nif == null || nif.isBlank()) {
                request.setAttribute("erro", "Tutor autenticado mas não existe na tabela CLIENTE (email não encontrado).");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            session.setAttribute("userNif", nif.trim());
        }


        response.sendRedirect(request.getContextPath() + redirectByRole(user.getRole()));
    }

    private String redirectByRole(String role) {
        if (role == null) return "/index.jsp";

        return switch (role) {
            case "rececionista" -> "/rececionista/home.jsp";
            case "veterinario"  -> "/veterinario/home.jsp";
            case "tutor"        -> "/tutor/home.jsp";
            case "gerente"      -> "/gerente/home.jsp";
            default             -> "/index.jsp";
        };
    }
}
