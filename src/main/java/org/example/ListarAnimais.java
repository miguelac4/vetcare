
package org.example;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ListarAnimais {

    // ⚠️ AJUSTA estes valores à tua base de dados
    private static final String URL =
            "jdbc:mysql://localhost:3306/vetCare";
    private static final String USER = "root";        // o user que usas no MySQL
    private static final String PASSWORD = "root";   // a tua password

    public static void main(String[] args) {
        listarAnimais();
    }

    public static void listarAnimais() {
        String sql = "SELECT idAnimal, nome, raca, sexo FROM Animal";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.printf("%-5s %-20s %-15s %-5s%n",
                    "ID", "Nome", "Raça", "Sexo");
            System.out.println("--------------------------------------------------");

            // Ler linha a linha
            while (rs.next()) {
                int id       = rs.getInt("idAnimal");
                String nome  = rs.getString("nome");
                String raca   = rs.getString("raca");
                String sexo    = rs.getString("sexo");

                System.out.printf("%-5d %-20s %-15s %-5s%n",
                        id, nome, raca, sexo);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao buscar dados da tabela Animal:");
            e.printStackTrace();
        }
    }
}
