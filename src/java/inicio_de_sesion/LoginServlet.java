/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package inicio_de_sesion;

import java.sql.Connection;
//import com.sun.jdi.connect.spi.Connection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;


/**
 *
 * @author Kevin Lima
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})

public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
        // Información de conexión a la base de datos
    private static final String DB_URL = "jdbc:mysql://localhost:3306/db_tiendaa";
    private static final String DB_USER = "root"; // Cambia esto a tu usuario de MySQL
    private static final String DB_PASSWORD = "alexanderlima"; // Cambia esto a tu contraseña de MySQL

    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
                    // Obtener el nombre de usuario y la contraseña desde el formulario
        String usuario = request.getParameter("username");
        String contraseña = request.getParameter("password");
        
        // Conexión a la base de datos
        try {
            // Cargar el controlador JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
                
            // Conectar a la base de datos
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Consulta SQL para verificar si el usuario y la contraseña existen
            String sql = "SELECT * FROM login WHERE usuario = ? AND contraseña = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usuario);
            ps.setString(2, contraseña);
            
            // Ejecutar la consulta
            ResultSet rs = ps.executeQuery();
            
            // Comprobar si hay un resultado
            if (rs.next()) {
                String nombre = rs.getString("usuario"); // Obtener el nombre del usuario

                // Guardar el nombre en la sesión
                HttpSession session = request.getSession();
                session.setAttribute("nombreUsuario", nombre);
                
                // Redirigir al menú principal
                response.sendRedirect("menu.jsp");
            } else {
                response.sendRedirect("index.jsp?error=1");
            }
            
            // Cerrar la conexión
            rs.close();
            ps.close();
            con.close();
        } catch (IOException | ClassNotFoundException | SQLException e) {
            response.sendRedirect("index.jsp?error=2"); // Error de conexión a la base de datos
        }       
        }


    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
