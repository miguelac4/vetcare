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


        HttpSession session = request.getSession(false);
        String role = (session == null) ? null : (String) session.getAttribute("userRole");

        // autorização por diretorias
        boolean isAllowed =
                (path.startsWith("/gerente/")      && role.equals("gerente")) ||
                        (path.startsWith("/veterinario/")  && role.equals("veterinario")) ||
                        (path.startsWith("/tutor/")        && role.equals("tutor")) ||
                        (path.startsWith("/rececionista/") && role.equals("rececionista"));

        // Se não está em nenhuma área protegida, deixa passar (ex.: /listarAnimais, /api/*, etc.)
        boolean isRoleArea = path.startsWith("/gerente/") || path.startsWith("/veterinario/")
                || path.startsWith("/tutor/") || path.startsWith("/rececionista/");

        if (isRoleArea && !isAllowed) {
            // bloquear com 403 e mensagem de erro
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("404 | Acesso negado: não tens permissões para aceder a esta página.");
            return;
        }

        chain.doFilter(req, res);
    }
}
