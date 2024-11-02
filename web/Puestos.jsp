<%-- 
    Document   : index
    Created on : 17/10/2024, 11:58:12 p. m.
    Author     : felix
--%>

<%@page import="modelo.Puesto"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Puestos</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    </head>
    <body>
        <div class="d-flex justify-content-center">
        <h1>Formulario Puestos</h1>
        </div>
        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modal_puesto" onclick="limpiar()">Nuevo Puesto</button>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>  
        <div class="container">
         <div class="modal fade" id="modal_puesto" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content"> 
            <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Nuevos Puestos</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <form action="sr_puesto" method="post" class="form-group" >
                <label for="lbl_id"><b>ID Puesto:</b> </label>
                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                <label for="lbl_puesto"><b>Puesto:</b> </label>
                <input type="text" name="txt_puesto" id="txt_puesto" class="form-control" placeholder="Ejemplo: Puesto X" required>
                <br>
                <button value="agregar" class="btn btn-primary" name="btn_agregar" id="btn_agregar">Agregar</button>
                <button value="modificar" class="btn btn-success" name="btn_modificar" id="btn_modificar">Modificar</button>
                <button value="eliminar" class="btn btn-danger" name="btn_eliminar" onclick="javascript:if(!confirm('Eliminar 100%')) return false">Eliminar</button>
                <a href="puesto.jsp" class="btn btn-warning" target="target">Puestos</a>          
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
      </div>
        </div>
    </div>
         </div>
    
               <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID Puesto</th>
                            <th>Puesto</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_puesto">
                        <%
                        Puesto puesto = new Puesto();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = puesto.leer();
                        for (int t=0;t<tabla.getRowCount();t++){
                            out.println("<tr data-id='"+ tabla.getValueAt(t, 0) +"'>");
                            out.println("<td>"+ tabla.getValueAt(t, 0) +"</td>");
                            out.println("<td>"+ tabla.getValueAt(t, 1) +"</td>");
                            out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    <script type="text/javascript">
            function limpiar(){
               $("#txt_id").val(0);
                $("#txt_puesto").val('');
            }
            
            $('#tbl_puesto').on('click','tr td',function(evt){
                var target,id,puesto;
                target = $(event.target);
                id = target.parent().data('id');
                puesto = target.parent("tr").find("td").eq(1).html();
                $("#txt_id").val(id);
                $("#txt_puesto").val(puesto);
                $("#modal_puesto").modal('show');
            });
        </script>
    </body>
</html>