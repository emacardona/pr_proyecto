<%-- 
    Document   : empleados
    Created on : 11/10/2024, 07:46:48 PM
    Author     : USUARIO
--%>
<%@page import="modelo.Puesto"%>
<%@page import="modelo.Empleado" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        
        <div class="container">                        
        <br><h3 style="text-align: center;">Lista de empleados</h3><br>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" style="text-align: center;">
            Ingrese un nuevo empleado
        </button><br><br>

        <!-- Inicio de formulario: Modificar empleado -->
        <div class="modal fade" id="modal_ME">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="sr_empleado" method="post" class="form-group" >
                        
                            <div class="modal-header" >
                                <h4 class="modal-title text-danger" ><b>Modificar/Eliminar empleado</b></h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                    
                            <div class="modal-body">
                                <label><b>ID del Empleado</b></label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                                <label><b>Nombres: </b></label>
                                <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" required>
                                <label><b>Apellidos: </b></label>
                                <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" required>
                                <label><b>Dirección: </b></label>
                                <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" required>
                                <label><b>Telefono: </b></label>
                                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" required>
                                <label><b>DPI del empleado: </b></label>
                                <input type="text" name="txt_dpi" id="txt_dpi" class="form-control" required>
                                <label><b>Genero: </b></label>
                                <select name="drop_genero" id="drop_genero" class="form-control" >
                                    <option>--Elija una opcion--</option>
                                    <option value="1">Masculino</option>
                                    <option value="0">Femenino</option>
                                </select>
                                <label><b>Fecha de nacimiento: </b></label>
                                <input type="date" name="txt_fn" id="txt_fn" class="form-control" required>
                                <label><b>Puesto: </b></label>
                                <select name="drop_puesto" id="drop_puesto" class="form-control" >
                                    <% 
                                        Puesto  elegir_puestoM = new Puesto();
                                        HashMap<String,String> dropM = elegir_puestoM.drop_puestos();
                                        for(String i: dropM.keySet()){
                                        out.println("<option value='" + i + "' >" + dropM.get(i) +"</option>");
                                    }
                                    %>
                                </select>

                                <label><b>Fecha de inicio de labores: </b></label>
                                <input type="date" name="txt_fil" id="txt_fil" class="form-control" required>
                                <label><b>Fecha de ingreso: </b></label>
                                <input type="date" name="txt_f_ingreso" id="txt_f_ingreso" class="form-control" >
                            </div>
                    
                            <br>
                            <div class="modal-footer">
                                <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-dark btn-lg">Modificar</button>
                                <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="javascript:if(!confirm('¿Desea Eliminar?'))return false">Eliminar</button>
                            </div>
                        </form>    
                    </div>
                </div>
            </div>
        
        <!-- Fin de formulario: Modificar empleado -->
        
        <!-- Inicio de formulario: Ingresar nuevo empleado -->
        
    <div class="modal fade" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="sr_empleado" method="post" class="form-group" >
                        
                            <div class="modal-header">
                                <h4 class="modal-title text-info" ><b >Ingreso de nuevo empleado</b></h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                    
                            <div class="modal-body">
                                <label><b>ID del Empleado</b></label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                                <label><b>Nombres: </b></label>
                                <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Ejemplo: Juan Pedro" required>
                                <label><b>Apellidos: </b></label>
                                <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Ejemplo: Lopez Perez" required>
                                <label><b>Dirección: </b></label>
                                <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Ejemplo: Guatemala" required>
                                <label><b>Telefono: </b></label>
                                <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ejemplo: 1234-5678" required>
                                <label><b>DPI del empleado: </b></label>
                                <input type="text" name="txt_dpi" id="txt_dpi" class="form-control" placeholder="Ejemplo: 2320 55634 0103" required>
                                <label><b>Genero: </b></label>
                                <select name="drop_genero" id="drop_genero" class="form-control" >
                                    <option>--Elija una opcion--</option>
                                    <option value="1">Masculino</option>
                                    <option value="0">Femenino</option>
                                </select>
                                <label><b>Fecha de nacimiento: </b></label>
                                <input type="date" name="txt_fn" id="txt_fn" class="form-control" required>
                                <label><b>Puesto: </b></label>
                                <select name="drop_puesto" id="drop_puesto" class="form-control" >
                                    <% 
                                        Puesto  elegir_puesto = new Puesto();
                                        HashMap<String,String> dropE = elegir_puesto.drop_puestos();
                                        for(String i: dropE.keySet()){
                                        out.println("<option value='" + i + "' >" + dropM.get(i) +"</option>");
                                    }
                                    %>
                                </select>
                                <label><b>Fecha de inicio de labores: </b></label>
                                <input type="date" name="txt_fil" id="txt_fil" class="form-control" required>
                                <label><b>Fecha de ingreso: </b></label>
                                <input type="datetime-local" name="txt_f_ingreso" id="txt_f_ingreso" class="form-control" required>
                            </div>
                    
                            <br>
                            <div class="modal-footer">
                                <button class="btn btn-info btn-block"  name="btn_agregar" id="btn_agregar" value="agregar"><b>Agregar</b></button>
                            </div>
                        </form>    
                    </div>
                </div>
            </div>        
        <!-- Fin de formulario: Ingresar nuevo empleado -->                    
                      
        <!-- Inicio tabla empleados -->        
            <table class="table table-hover " style="text-align: center; ">
                <thead class="thead-dark">
                    <tr>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Direccion</th>
                        <th>Telefono</th>
                        <th>DPI</th>
                        <th>Genero</th>
                        <th>Fecha de nacimiento</th>
                        <th>Puesto</th>
                        <th>Fecha de inicio de labores</th>
                        <th>Fecha de ingreso</th>
                    </tr>
                </thead>
                <tbody id="tbl_empleados" class="table-bordered">                    
                    <% 
                        Empleado empleado = new Empleado();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = empleado.leer();
                        for (int t=0;t<tabla.getRowCount();t++){                          
                            out.println("<tr data-id=" + tabla.getValueAt(t,0) + " data-id_p=" + tabla.getValueAt(t,9) + ">");                                
                            out.println("<td>" + tabla.getValueAt(t,1) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,2) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,3) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,4) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,5) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,6) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,7) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,8) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,10) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t,11) + "</td>");
                            out.println("</tr>");
                        }
                    %>               
                </tbody>
            </table>
        </div>                             
        <!-- Fin tabla empleados -->
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>    
        <script>
            
            $('#tbl_empleados').on('click','tr td', function(evt){
               var target,id,id_p,nombres,apellidos,direccion,telefono,dpi,genero,fecha_nacimiento,fecha_inicio_labores,fecha_ingreso;
               
               target = $(event.target);
               id = target.parent().data('id');
               id_p = target.parent().data('id_p');
               nombres = target.parents("tr").find("td").eq(0).html();
               apellidos = target.parents("tr").find("td").eq(1).html();
               direccion = target.parents("tr").find("td").eq(2).html();
               telefono = target.parents("tr").find("td").eq(3).html();
               dpi = target.parents("tr").find("td").eq(4).html();
               genero = target.parents("tr").find("td").eq(5).html();
               fecha_nacimiento = target.parents("tr").find("td").eq(6).html();             
               fecha_inicio_labores = target.parents("tr").find("td").eq(8).html();
               fecha_ingreso = target.parents("tr").find("td").eq(8).html();
               
              
               $("#txt_id").val(id);
               $("#txt_nombres").val(nombres);
               $("#txt_apellidos").val(apellidos);
               $("#txt_direccion").val(direccion);
               $("#txt_telefono").val(telefono);
               $("#txt_dpi").val(dpi);
               $("#drop_genero").val(genero);
               $("#txt_fn").val(fecha_nacimiento);
               $("#drop_puesto").val(id_p);               
               $("#txt_fil").val(fecha_inicio_labores);
               $("#txt_f_ingreso").val(fecha_ingreso);               
               $("#modal_ME").modal('show');                                             
            });           
        </script>
    </body>
</html>
