package org.example.vetcare.api;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.dao.HistoricoClinicoDao;
import org.example.vetcare.model.Animal;
import org.example.vetcare.model.HistoricoClinico;

import java.io.IOException;
import java.util.List;

@WebServlet("/gerente/animais/exportar-json")
public class ExportarJSONServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();
    private final HistoricoClinicoDao historicoDao = new HistoricoClinicoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!"gerente".equals(role)) { response.sendError(403); return; }

        String idStr = request.getParameter("idAnimal");
        if (idStr == null || idStr.isBlank()) { response.sendError(400, "idAnimal em falta."); return; }

        int idAnimal;
        try { idAnimal = Integer.parseInt(idStr); }
        catch (NumberFormatException e) { response.sendError(400, "idAnimal inválido."); return; }

        Animal a = animalDao.findById(idAnimal);
        if (a == null) { response.sendError(404, "Animal não encontrado."); return; }

        List<HistoricoClinico> hist = historicoDao.findByAnimal(idAnimal);

        String json = buildJson(a, hist);

        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"animal_" + idAnimal + ".json\"");
        response.getWriter().write(json);
    }

    private String buildJson(Animal a, List<HistoricoClinico> hist) {
        StringBuilder sb = new StringBuilder();
        sb.append("{");

        // -------- fichaAnimal --------
        sb.append("\"fichaAnimal\":{");
        sb.append("\"idAnimal\":").append(a.getIdAnimal()).append(",");
        sb.append("\"nome\":\"").append(esc(a.getNome())).append("\",");
        sb.append("\"raca\":\"").append(esc(a.getRaca())).append("\",");
        sb.append("\"sexo\":\"").append(esc(a.getSexo())).append("\",");

        sb.append("\"dataNascimento\":")
                .append(a.getDataNascimento() == null ? "null" : "\"" + esc(a.getDataNascimento().toString()) + "\"")
                .append(",");

        sb.append("\"idPai\":").append(a.getIdPai() == null ? "null" : a.getIdPai()).append(",");
        sb.append("\"idMae\":").append(a.getIdMae() == null ? "null" : a.getIdMae()).append(",");

        sb.append("\"estadoReprodutivo\":\"").append(esc(a.getEstadoReprodutivo())).append("\",");
        sb.append("\"alergia\":\"").append(esc(a.getAlergia())).append("\",");
        sb.append("\"cor\":\"").append(esc(a.getCor())).append("\",");
        sb.append("\"fotografia\":\"").append(esc(a.getFotografia())).append("\",");

        sb.append("\"peso\":").append(a.getPeso() == null ? "null" : a.getPeso()).append(",");
        sb.append("\"distintivas\":\"").append(esc(a.getDistintivas())).append("\",");
        sb.append("\"numChip\":\"").append(esc(a.getNumChip())).append("\",");

        sb.append("\"nif\":\"").append(esc(a.getNif())).append("\",");
        sb.append("\"idTaxonomia\":").append(a.getIdTaxonomia() == null ? "null" : a.getIdTaxonomia());

        sb.append("},");

        // -------- historicoClinico --------
        sb.append("\"historicoClinico\":{");
        sb.append("\"registos\":[");

        if (hist != null) {
            for (int i = 0; i < hist.size(); i++) {
                HistoricoClinico h = hist.get(i);
                if (i > 0) sb.append(",");

                sb.append("{");
                sb.append("\"idHistorico\":").append(h.getIdHistorico()).append(",");
                sb.append("\"numLicenca\":\"").append(esc(h.getNumLicenca())).append("\",");
                sb.append("\"descricao\":\"").append(esc(h.getDescricao())).append("\",");

                sb.append("\"criadoEm\":")
                        .append(h.getCriadoEm() == null ? "null" : "\"" + esc(h.getCriadoEm().toString()) + "\"");

                sb.append("}");
            }
        }

        sb.append("]}"); // fecha registos + historicoClinico

        sb.append("}");
        return sb.toString();
    }

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
