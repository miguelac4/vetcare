package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.vetcare.dao.UserDao;
import org.example.vetcare.model.User;

import java.io.IOException;

@WebServlet("/gerente/utilizadores/rececionistas/editar")
public class EditarRececionistaServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!"gerente".equals(role)) { response.sendError(403); return; }

        int id = Integer.parseInt(request.getParameter("id"));
        User u = userDao.findById(id);
        if (u == null || !"rececionista".equals(u.getRole())) { response.sendError(404); return; }

        request.setAttribute("user", u);
        request.getRequestDispatcher("/gerente/editarRececionista.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!"gerente".equals(role)) { response.sendError(403); return; }

        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");

        userDao.update(id, nome.trim(), email.trim());
        response.sendRedirect(request.getContextPath() + "/gerente/utilizadores/rececionistas");
    }
}
