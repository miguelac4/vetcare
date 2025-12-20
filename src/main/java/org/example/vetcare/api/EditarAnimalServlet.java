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
        fileSizeThreshold = 1024 * 1024,      // 1MB
        maxFileSize = 5 * 1024 * 1024,         // 5MB
        maxRequestSize = 10 * 1024 * 1024      // 10MB
)
@WebServlet("/rececionista/animal/editar")
public class EditarAnimalServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();
    private final TaxonomiaDao taxonomiaDao = new TaxonomiaDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // segurança po role
        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!role.equals("rececionista")) { response.sendError(403); return; }

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "id em falta.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "id inválido.");
            return;
        }

        Animal animal = animalDao.findById(id);
        if (animal == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Animal não encontrado.");
            return;
        }

        request.setAttribute("animal", animal);

        // dropdowns (pai/mãe)
        request.setAttribute("animaisDoTutor", animalDao.findAllByNif(animal.getNif()));
        request.setAttribute("taxonomias", taxonomiaDao.findAll());

        request.getRequestDispatcher("/rececionista/editarAnimal.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("userRole");
        if (role == null) { response.sendError(401); return; }
        if (!role.equals("rececionista")) { response.sendError(403); return; }

        String idStr = request.getParameter("idAnimal");
        String nif = request.getParameter("nif");

        if (idStr == null || idStr.isBlank() || nif == null || nif.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parâmetros em falta.");
            return;
        }

        int idAnimal;
        try {
            idAnimal = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "idAnimal inválido.");
            return;
        }

        nif = nif.trim();

        // manter a foto antiga caso não haja upload
        Animal atual = animalDao.findById(idAnimal);
        if (atual == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Animal não encontrado.");
            return;
        }

        Animal a = new Animal();
        a.setIdAnimal(idAnimal);
        a.setNif(nif);

        a.setNome(request.getParameter("nome"));
        a.setRaca(request.getParameter("raca"));
        a.setSexo(request.getParameter("sexo"));

        try {
            a.setIdPai(parseNullableInt(request.getParameter("idPai")));
            a.setIdMae(parseNullableInt(request.getParameter("idMae")));
            a.setIdTaxonomia(parseNullableInt(request.getParameter("idTaxonomia")));
        } catch (NumberFormatException e) {
            forwardComErro(request, response, atual, "Pai/Mãe/Taxonomia inválidos (usa ids numéricos ou vazio).");
            return;
        }

//        if (a.getIdTaxonomia() == null) {
//            forwardComErro(request, response, atual, "Tem de selecionar uma taxonomia.");
//            return;
//        }

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
                forwardComErro(request, response, atual, "Peso inválido.");
                return;
            }
        } else {
            a.setPeso(null);
        }

        String data = request.getParameter("dataNascimento");
        if (data != null && !data.isBlank()) {
            try {
                a.setDataNascimento(java.time.LocalDate.parse(data));
            } catch (Exception e) {
                forwardComErro(request, response, atual, "Data de nascimento inválida.");
                return;
            }
        } else {
            a.setDataNascimento(null);
        }

        a.setFotografia(atual.getFotografia());

        // upload
        Part fotoPart = request.getPart("fotografia");
        if (fotoPart != null && fotoPart.getSize() > 0) {

            String submitted = fotoPart.getSubmittedFileName();
            String ext = getExtension(submitted);

            if (ext.isBlank()) {
                forwardComErro(request, response, atual, "Formato de imagem inválido (usa jpg/png/webp).");
                return;
            }

            String base = System.getProperty("catalina.base");
            Path uploadDir = Paths.get(base, "vetcare_uploads", "animais");
            Files.createDirectories(uploadDir);

            String fileName = idAnimal + ext;
            Path filePath = uploadDir.resolve(fileName);

            deleteIfExists(uploadDir.resolve(idAnimal + ".jpg"));
            deleteIfExists(uploadDir.resolve(idAnimal + ".jpeg"));
            deleteIfExists(uploadDir.resolve(idAnimal + ".png"));
            deleteIfExists(uploadDir.resolve(idAnimal + ".webp"));

            fotoPart.write(filePath.toString());

            a.setFotografia("/uploads/animais/" + fileName);
        }

        animalDao.update(a);

        response.sendRedirect(request.getContextPath() + "/animais?nif=" + nif);
    }

    private Integer parseNullableInt(String v) throws NumberFormatException {
        if (v == null) return null;
        v = v.trim();
        if (v.isEmpty()) return null;
        return Integer.parseInt(v);
    }

    private void forwardComErro(HttpServletRequest request, HttpServletResponse response, Animal atual, String msg)
            throws ServletException, IOException {

        request.setAttribute("erro", msg);

        // importante: voltar a enviar o animal atual (ou os valores submetidos, se quiseres)
        request.setAttribute("animal", atual);

        // dropdowns
        request.setAttribute("animaisDoTutor", animalDao.findAllByNif(atual.getNif()));
        request.setAttribute("taxonomias", taxonomiaDao.findAll());

        request.getRequestDispatcher("/rececionista/editarAnimal.jsp").forward(request, response);
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
}
