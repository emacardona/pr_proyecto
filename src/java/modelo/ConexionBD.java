/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    
        private static final String url = "jdbc:mysql://localhost:3306/db_tienda";
    private static final String user = "root"; // Cambia esto a tu usuario de MySQL
    private static final String password = "kevinlima"; // Cambia esto a tu contraseña de MySQL

    public Connection conectar() throws SQLException {
        Connection con = null;
        try {
            // Asegurarse de que el driver JDBC esté registrado
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error cargando el driver JDBC de MySQL", e);
        }
        return con;
    }

    public void desconectar(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                System.out.println("Error cerrando la conexión a la base de datos");
            }
        }
    }
}
