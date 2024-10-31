/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package modelo;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Image;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.draw.LineSeparator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/pdfgenerator")
public class PdfGeneratorServelet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        try {
            // Registrar el controlador JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Error al cargar el controlador JDBC: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipo = request.getParameter("tipo");

        // Parámetros de conexión a la base de datos
        String url = "jdbc:mysql://localhost:3306/db_tiendaa?useSSL=false";
        String user = "root";
        String password = "alexanderlima";

        try {
            switch (tipo) {
                case "clientes":
                    generateClientesPdf(url, user, password, response);
                    break;
                case "productos":
                    generateProductosPdf(url, user, password, response);
                    break;
                case "ventas":
                    generateVentasPdf(url, user, password, response);
                    break;
                default:
                    response.getWriter().println("Tipo de PDF no válido.");
                    break;
            }
        } catch (SQLException | DocumentException e) {
            response.getWriter().println("Error en la generación del PDF: " + e.getMessage());
        }
    }

    private void generateClientesPdf(String url, String user, String password, HttpServletResponse response) throws IOException, DocumentException, SQLException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=clientes.pdf");

        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Título centrado y con formato
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD, BaseColor.BLUE);
        Paragraph title = new Paragraph("Reporte de Clientes", titleFont);
        title.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(title);
        
        // Línea horizontal
        document.add(new Paragraph("\n"));
        document.add(new LineSeparator());
        document.add(new Paragraph("\n"));

        // Tabla de clientes
        PdfPTable table = new PdfPTable(8);
        table.setWidthPercentage(100);

        // Encabezados de la tabla de clientes
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        table.addCell(new Phrase("ID Cliente", headerFont));
        table.addCell(new Phrase("Nombres", headerFont));
        table.addCell(new Phrase("Apellidos", headerFont));
        table.addCell(new Phrase("NIT", headerFont));
        table.addCell(new Phrase("Género", headerFont));
        table.addCell(new Phrase("Teléfono", headerFont));
        table.addCell(new Phrase("Correo Electrónico", headerFont));
        table.addCell(new Phrase("Fecha de Ingreso", headerFont));

        // Datos de la base de datos
        try (Connection connection = DriverManager.getConnection(url, user, password);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT id_Cliente, nombres, apellidos, NIT, genero, telefono, correo_electronico, fecha_ingreso FROM clientes")) {

            while (resultSet.next()) {
                table.addCell(String.valueOf(resultSet.getInt("id_Cliente")));
                table.addCell(resultSet.getString("nombres"));
                table.addCell(resultSet.getString("apellidos"));
                table.addCell(resultSet.getString("NIT"));
                table.addCell(resultSet.getString("genero"));
                table.addCell(resultSet.getString("telefono"));
                table.addCell(resultSet.getString("correo_electronico"));
                table.addCell(resultSet.getString("fecha_ingreso"));
            }

            document.add(table);
            document.close();
        }
    }

    private void generateProductosPdf(String url, String user, String password, HttpServletResponse response) throws IOException, DocumentException, SQLException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=productos.pdf");

        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Título centrado y con formato
        Font titleFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD, BaseColor.BLUE);
        Paragraph title = new Paragraph("Reporte de Productos", titleFont);
        title.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(title);
        
        // Línea horizontal
        document.add(new Paragraph("\n"));
        document.add(new LineSeparator());
        document.add(new Paragraph("\n"));

        // Tabla de productos
        PdfPTable table = new PdfPTable(9);
        table.setWidthPercentage(100);

        // Encabezados de la tabla de productos
        Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
        table.addCell(new Phrase("ID Producto", headerFont));
        table.addCell(new Phrase("Producto", headerFont));
        table.addCell(new Phrase("ID Marca", headerFont));
        table.addCell(new Phrase("Descripción", headerFont));
        table.addCell(new Phrase("Imagen", headerFont));
        table.addCell(new Phrase("Precio Costo", headerFont));
        table.addCell(new Phrase("Precio Venta", headerFont));
        table.addCell(new Phrase("Existencia", headerFont));
        table.addCell(new Phrase("Fecha de Ingreso", headerFont));

        // Datos de la base de datos
        try (Connection connection = DriverManager.getConnection(url, user, password);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery("SELECT id_Producto, producto, id_Marca, Descripcion, Imagen, precio_costo, precio_venta, existencia, fecha_ingreso FROM productos")) {

            while (resultSet.next()) {
                table.addCell(String.valueOf(resultSet.getInt("id_Producto")));
                table.addCell(resultSet.getString("producto"));
                table.addCell(String.valueOf(resultSet.getInt("id_Marca")));
                table.addCell(resultSet.getString("Descripcion"));
                table.addCell(resultSet.getString("Imagen"));
                table.addCell(String.valueOf(resultSet.getDouble("precio_costo")));
                table.addCell(String.valueOf(resultSet.getDouble("precio_venta")));
                table.addCell(String.valueOf(resultSet.getInt("existencia")));
                table.addCell(resultSet.getString("fecha_ingreso"));
            }

            document.add(table);
            document.close();
        }
    }

private void generateVentasPdf(String url, String user, String password, HttpServletResponse response) throws IOException, DocumentException, SQLException {
    Document document = new Document();
    PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    // Título centrado y con formato
    Font titleFont = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD, BaseColor.BLUE);
    Paragraph title = new Paragraph("Reporte de Ventas", titleFont);
    title.setAlignment(Paragraph.ALIGN_CENTER);
    document.add(title);
    
    // Línea horizontal
    document.add(new Paragraph("\n"));
    document.add(new LineSeparator());
    document.add(new Paragraph("\n"));

    // Tabla de ventas
    PdfPTable table = new PdfPTable(7); // Ajusta el número de columnas según los campos que agregaste
    table.setWidthPercentage(100);

    // Encabezados de la tabla de ventas
    Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
    table.addCell(new Phrase("ID Venta", headerFont));
    table.addCell(new Phrase("No. Factura", headerFont));
    table.addCell(new Phrase("Serie", headerFont));
    table.addCell(new Phrase("Fecha Factura", headerFont));
    table.addCell(new Phrase("ID Cliente", headerFont));
    table.addCell(new Phrase("ID Empleado", headerFont));
    table.addCell(new Phrase("Fecha Ingreso", headerFont));

    // Datos de la base de datos
    try (Connection connection = DriverManager.getConnection(url, user, password);
         Statement statement = connection.createStatement();
         ResultSet resultSet = statement.executeQuery("SELECT id_Venta, no_factura, serie, fecha_factura, id_Cliente, id_Empleado, fecha_ingreso FROM ventas")) {

        while (resultSet.next()) {
            table.addCell(String.valueOf(resultSet.getInt("id_Venta")));          // ID Venta
            table.addCell(resultSet.getString("no_factura"));                     // No. Factura
            table.addCell(resultSet.getString("serie"));                           // Serie
            table.addCell(resultSet.getString("fecha_factura"));                   // Fecha Factura
            table.addCell(String.valueOf(resultSet.getInt("id_Cliente")));         // ID Cliente
            table.addCell(String.valueOf(resultSet.getInt("id_Empleado")));        // ID Empleado
            table.addCell(resultSet.getString("fecha_ingreso"));                   // Fecha Ingreso
        }

        document.add(table);
        document.close();
    }
}

}

