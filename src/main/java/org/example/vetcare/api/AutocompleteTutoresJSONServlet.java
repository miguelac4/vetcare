package org.example.vetcare.api;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.ClienteDao;
import org.example.vetcare.model.Cliente;

import java.io.IOException;
import java.util.List;

@WebServlet("/veterinario/autocomplete-tutores")
public class AutocompleteTutoresJSONServlet extends HttpServlet {

    private final ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String q = request.getParameter("q");
        if (q == null) q = "";
        q = q.trim();

        response.setContentType("application/json;charset=UTF-8");

        if (q.length() < 2) {
            response.getWriter().write("[]");
            return;
        }

        List<Cliente> resultados = clienteDao.searchByNome(q, 10);

        // JSON simples "na mão" (sem libs)
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < resultados.size(); i++) {
            Cliente c = resultados.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                    .append("\"nif\":\"").append(escape(c.getNif())).append("\",")
                    .append("\"nome\":\"").append(escape(c.getNome())).append("\",")
                    .append("\"email\":\"").append(escape(c.getEmail())).append("\"")
                    .append("}");
        }
        json.append("]");

        response.getWriter().write(json.toString());
    }

    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
