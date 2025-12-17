package org.example.vetcare.api;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

/*

AuthFilter

Ele verifica:

- se a rota é pública (/login, css/js/imagens, etc.)
- se não for pública, exige que exista sessão com userRole
- se não houver sessão → faz redirect para /login

*/



@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        // Rotas públicas (não exigem login)
        boolean isPublic =
                path.equals("/login") ||
                        path.equals("/login.jsp") ||
                        path.startsWith("/css/") ||
                        path.startsWith("/js/") ||
                        path.startsWith("/images/") ||
                        path.startsWith("/uploads/"); // se estás a servir fotos via servlet /uploads

        if (isPublic) {
            chain.doFilter(req, res);
            return;
        }

        // Exigir login para tudo o resto
        HttpSession session = request.getSession(false);
        String role = (session == null) ? null : (String) session.getAttribute("userRole");

        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Autorização por diretorias
        boolean isRoleArea =
                path.startsWith("/gerente/") ||
                        path.startsWith("/veterinario/") ||
                        path.startsWith("/tutor/") ||
                        path.startsWith("/rececionista/");

        if (isRoleArea) {
            boolean isAllowed =
                    (path.startsWith("/gerente/")      && role.equals("gerente")) ||
                            (path.startsWith("/veterinario/")  && role.equals("veterinario")) ||
                            (path.startsWith("/tutor/")        && role.equals("tutor")) ||
                            (path.startsWith("/rececionista/") && role.equals("rececionista"));

            if (!isAllowed) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN,
                        "Acesso negado: não tens permissões para aceder a esta página.");
                return;
            }
        }

        // Rotas fora das diretorias (ex.: /animais) → já estão protegidas por login
        chain.doFilter(req, res);
    }
}
