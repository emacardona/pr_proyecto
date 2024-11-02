package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Puesto {
    private int id_puesto;
    private String puesto;
    private Conexion cn;

    // Constructor
    public Puesto() {}
    public Puesto(int id_puesto, String puesto) {
        this.id_puesto = id_puesto;
        this.puesto = puesto;
    }

    // Getters y Setters
    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    // Método para leer puestos activos
    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT id_puesto as id, puesto FROM puestos WHERE estado = 1;"; // Solo muestra puestos activos
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String[] encabezado = {"ID", "Puesto"};
            tabla.setColumnIdentifiers(encabezado);
            String[] datos = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("puesto");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }

    // Método para agregar un nuevo puesto
    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO puestos (puesto, estado) VALUES ( ? , 1);"; // Estado activo por defecto
            cn.abrir_conexion();
            parametro = cn.conexionBD.prepareStatement(query);
            parametro.setString(1, this.getPuesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Método para modificar un puesto existente
    public int modificar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE puestos SET puesto = ? WHERE id_Puesto = ?;";
            cn.abrir_conexion();
            parametro = cn.conexionBD.prepareStatement(query);
            parametro.setString(1, this.getPuesto());
            parametro.setInt(2, this.getId_puesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Método para eliminar un puesto (cambiar el estado a inactivo)
    public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE puestos SET estado = \"inactivo\" WHERE id_Puesto = ?;"; // Cambiar el estado a inactivo
            cn.abrir_conexion();
            parametro = cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getId_puesto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    // Método para llenar un HashMap con los puestos (para uso en JComboBox, por ejemplo)
    public HashMap<String, String> drop_puestos() {
        HashMap<String, String> drop = new HashMap<>();
        try {
            cn = new Conexion();
            String query = "SELECT id_puesto as id, puesto FROM puestos WHERE estado = 1;"; // Solo muestra puestos activos
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            while (consulta.next()) {
                drop.put(consulta.getString("id"), consulta.getString("puesto"));
            }
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return drop;
    }
}
