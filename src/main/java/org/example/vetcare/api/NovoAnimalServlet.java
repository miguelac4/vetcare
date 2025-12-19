package org.example.vetcare.api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.vetcare.dao.AnimalDao;
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

        request.setAttribute("nif", nif.trim());
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
            request.setAttribute("erro", "NIF e Nome são obrigatórios.");
            request.setAttribute("nif", nif);
            request.getRequestDispatcher("/rececionista/novoAnimal.jsp").forward(request, response);
            return;
        }

        Animal a = new Animal();
        a.setNif(nif.trim());
        a.setNome(nome.trim());

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
                request.setAttribute("erro", "Peso inválido.");
                request.setAttribute("nif", nif);
                request.getRequestDispatcher("/rececionista/novoAnimal.jsp").forward(request, response);
                return;
            }
        }

        String data = request.getParameter("dataNascimento");
        if (data != null && !data.isBlank()) {
            try {
                a.setDataNascimento(java.time.LocalDate.parse(data));
            } catch (Exception e) {
                request.setAttribute("erro", "Data de nascimento inválida.");
                request.setAttribute("nif", nif);
                request.getRequestDispatcher("/rececionista/novoAnimal.jsp").forward(request, response);
                return;
            }
        }

        // 1) inserir primeiro (para obter idAnimal)
        int newId = animalDao.insertAndReturnId(a);
        if (newId <= 0) {
            request.setAttribute("erro", "Erro ao criar animal.");
            request.setAttribute("nif", nif);
            request.getRequestDispatcher("/rececionista/novoAnimal.jsp").forward(request, response);
            return;
        }

        // 2) upload foto (opcional) -> grava e faz update do path
        Part fotoPart = request.getPart("fotografia");
        if (fotoPart != null && fotoPart.getSize() > 0) {

            String submitted = fotoPart.getSubmittedFileName();
            String ext = getExtension(submitted);

            if (ext.isBlank()) {
                request.setAttribute("erro", "Formato de imagem inválido (usa jpg/png/webp).");
                request.setAttribute("nif", nif);
                request.getRequestDispatcher("/rececionista/novoAnimal.jsp").forward(request, response);
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
