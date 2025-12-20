package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.dao.TaxonomiaDao;
import org.example.vetcare.model.Animal;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
@WebServlet("/rececionista/animal/novo")
public class NovoAnimalServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();
    private final TaxonomiaDao taxonomiaDao = new TaxonomiaDao();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // segurança: só rececionista
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!role.equals("rececionista")) { response.sendError(403); return; }

        String nif = request.getParameter("nif");
        if (nif == null || nif.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "NIF em falta.");
            return;
        }

        nif = nif.trim();

        request.setAttribute("nif", nif);

        // listas para os dropdowns
        request.setAttribute("animaisDoTutor", animalDao.findAllByNif(nif));
        request.setAttribute("taxonomias", taxonomiaDao.findAll());

        request.getRequestDispatcher("/rececionista/novoAnimal.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // segurança: só rececionista
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!role.equals("rececionista")) { response.sendError(403); return; }


        String nif = request.getParameter("nif");
        String nome = request.getParameter("nome");

        if (nif == null || nif.isBlank() || nome == null || nome.isBlank()) {
            forwardComErro(request, response, nif, "NIF e Nome são obrigatórios.");
            return;

        }

        Animal a = new Animal();
        a.setNif(nif.trim());
        a.setNome(nome.trim());

        a.setRaca(request.getParameter("raca"));
        a.setSexo(request.getParameter("sexo"));

        try {
            a.setIdPai(parseNullableInt(request.getParameter("idPai")));
            a.setIdMae(parseNullableInt(request.getParameter("idMae")));
            a.setIdTaxonomia(parseNullableInt(request.getParameter("idTaxonomia")));
        } catch (NumberFormatException e) {
            forwardComErro(request, response, nif, "idPai, idMae e idTaxonomia têm de ser números inteiros (ou vazios).");
            return;
        }

        if (a.getIdTaxonomia() == null) {
            forwardComErro(request, response, nif, "Tem de selecionar uma taxonomia.");
            return;
        }


        a.setEstadoReprodutivo(request.getParameter("estadoReprodutivo"));
        a.setAlergia(request.getParameter("alergia"));
        a.setCor(request.getParameter("cor"));
        a.setDistintivas(request.getParameter("distintivas"));
        a.setNumChip(request.getParameter("numChip"));

        String pesoStr = request.getParameter("peso");
        if (pesoStr != null && !pesoStr.isBlank()) {
            try {
                a.setPeso(Double.parseDouble(pesoStr));
            } catch (NumberFormatException e) {
                forwardComErro(request, response, nif, "Peso inválido.");
                return;

            }
        }

        String data = request.getParameter("dataNascimento");
        if (data != null && !data.isBlank()) {
            try {
                a.setDataNascimento(java.time.LocalDate.parse(data));
            } catch (Exception e) {
                forwardComErro(request, response, nif, "Data de nascimento inválida.");
                return;

            }
        }

        // 1) inserir primeiro (para obter idAnimal)
        int newId = animalDao.insertAndReturnId(a);
        if (newId <= 0) {
            forwardComErro(request, response, nif, "Erro ao criar animal.");
            return;

        }

        // 2) upload foto (opcional) -> grava e faz update do path
        Part fotoPart = request.getPart("fotografia");
        if (fotoPart != null && fotoPart.getSize() > 0) {

            String submitted = fotoPart.getSubmittedFileName();
            String ext = getExtension(submitted);

            if (ext.isBlank()) {
                forwardComErro(request, response, nif, "Formato de imagem inválido (usa jpg/png/webp).");
                return;

            }

            String base = System.getProperty("catalina.base");
            Path uploadDir = Paths.get(base, "vetcare_uploads", "animais");
            Files.createDirectories(uploadDir);

            String fileName = newId + ext;
            Path filePath = uploadDir.resolve(fileName);

            // apaga versões antigas (por segurança)
            deleteIfExists(uploadDir.resolve(newId + ".jpg"));
            deleteIfExists(uploadDir.resolve(newId + ".jpeg"));
            deleteIfExists(uploadDir.resolve(newId + ".png"));
            deleteIfExists(uploadDir.resolve(newId + ".webp"));

            fotoPart.write(filePath.toString());

            // guardar path no animal
            animalDao.updateFotografia(newId, "/uploads/animais/" + fileName);
        }

        response.sendRedirect(request.getContextPath() + "/animais?nif=" + nif.trim());
    }

    private Integer parseNullableInt(String v) throws NumberFormatException {
        if (v == null) return null;
        v = v.trim();
        if (v.isEmpty()) return null;
        return Integer.parseInt(v);
    }

    private void deleteIfExists(Path p) {
        try { Files.deleteIfExists(p); } catch (Exception ignored) {}
    }

    private String getExtension(String name) {
        if (name == null) return "";
        int dot = name.lastIndexOf('.');
        if (dot < 0) return "";
        String ext = name.substring(dot).toLowerCase();
        return switch (ext) {
            case ".jpg", ".jpeg", ".png", ".webp" -> ext;
            default -> "";
        };
    }

    private void forwardComErro(HttpServletRequest request, HttpServletResponse response, String nif, String msg)
            throws ServletException, IOException {

        String nifOk = (nif == null ? "" : nif.trim());

        request.setAttribute("erro", msg);
        request.setAttribute("nif", nifOk);

        // repor listas para os dropdowns
        if (!nifOk.isBlank()) {
            request.setAttribute("animaisDoTutor", animalDao.findAllByNif(nifOk));
        } else {
            request.setAttribute("animaisDoTutor", java.util.List.of());
        }
        request.setAttribute("taxonomias", taxonomiaDao.findAll());

        request.getRequestDispatcher("/rececionista/novoAnimal.jsp").forward(request, response);
    }

}
