package org.example.vetcare.api;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.*;

@WebServlet("/uploads/*")
public class UploadsServlet extends HttpServlet {

    private Path baseDir;

    @Override
    public void init() {
        // mesma pasta usada no upload
        String base = System.getProperty("catalina.base");
        baseDir = Paths.get(base, "vetcare_uploads");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Ex: /uploads/animais/2.jpg
        String requested = request.getPathInfo(); // "/animais/2.jpg"
        if (requested == null || requested.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // evita path traversal
        Path file = baseDir.resolve(requested.substring(1)).normalize();
        if (!file.startsWith(baseDir)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        if (!Files.exists(file) || Files.isDirectory(file)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = Files.probeContentType(file);
        if (contentType == null) contentType = "application/octet-stream";
        response.setContentType(contentType);
        response.setContentLengthLong(Files.size(file));

        try (OutputStream out = response.getOutputStream()) {
            Files.copy(file, out);
        }
    }
}
