package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class testConnection {
    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/vetcare";
        String user = "root";
        String password = "root";

        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            System.out.println("Ligação bem sucedida!");
        } catch (SQLException e) {
            System.out.println("Erro na ligação:");
            e.printStackTrace();
        }
    }
}
