package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.example.vetcare.dao.AnimalDao;
import org.example.vetcare.model.Animal;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

// MiltipartConfig para os uploads e imagens dos animais
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB
        maxFileSize = 5 * 1024 * 1024,         // 5MB
        maxRequestSize = 10 * 1024 * 1024      // 10MB
)
@WebServlet("/rececionista/animal/editar")
public class EditarAnimalServlet extends HttpServlet {

    private final AnimalDao animalDao = new AnimalDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Animal animal = animalDao.findById(id);
        request.setAttribute("animal", animal);

        request.getRequestDispatcher("/rececionista/editarAnimal.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        // Para manter a foto antiga caso não haja upload novo
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
        a.setFiliacao(request.getParameter("filiacao"));
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
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Peso inválido.");
                return;
            }
        }

        String data = request.getParameter("dataNascimento");
        if (data != null && !data.isBlank()) {
            try {
                a.setDataNascimento(java.time.LocalDate.parse(data)); // YYYY-MM-DD
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Data de nascimento inválida.");
                return;
            }
        }

        // por defeito mantém a fotografia atual
        a.setFotografia(atual.getFotografia());

        // --- UPLOAD ---
        Part fotoPart = request.getPart("fotografia");
        if (fotoPart != null && fotoPart.getSize() > 0) {

            String submitted = fotoPart.getSubmittedFileName();
            String ext = getExtension(submitted); // ".png", ".jpg", ...

            if (ext.isBlank()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Formato de imagem inválido (usa jpg/png/webp).");
                return;
            }

            // pasta de uploads (no catalina.base do Tomcat do IntelliJ)
            String base = System.getProperty("catalina.base");
            Path uploadDir = Paths.get(base, "vetcare_uploads", "animais");
            Files.createDirectories(uploadDir);

            String fileName = idAnimal + ext; // ex: "2.png"
            Path filePath = uploadDir.resolve(fileName);

            // (opcional) apaga ficheiros antigos com outras extensões para o mesmo id
            deleteIfExists(uploadDir.resolve(idAnimal + ".jpg"));
            deleteIfExists(uploadDir.resolve(idAnimal + ".jpeg"));
            deleteIfExists(uploadDir.resolve(idAnimal + ".png"));
            deleteIfExists(uploadDir.resolve(idAnimal + ".webp"));

            // grava
            fotoPart.write(filePath.toString());

            // guarda path a servir pelo UploadsServlet
            a.setFotografia("/uploads/animais/" + fileName);

            System.out.println("Guardado em: " + filePath.toAbsolutePath());
            System.out.println("Existe? " + Files.exists(filePath));
            System.out.println("Tamanho: " + Files.size(filePath));
        }

        animalDao.update(a);

        response.sendRedirect(request.getContextPath() + "/rececionista/animais?nif=" + nif);
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
