<%
    // Verificar si el usuario ha iniciado sesión
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    if (nombreUsuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Dinámico</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Fondo del menú */
        .menu-background {
            flex-grow: 1;
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
        }

        header {
            padding: 20px;
            text-align: center;
            background-color: rgba(0, 0, 0, 1);
            color: white;
            font-size: 2rem;
        }

        nav {
            background-color: rgba(0, 0, 0, 1);
            padding: 10px;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            position: relative;
            margin: 0 15px;
            display: inline-block;
        }

        nav ul ul {
            position: absolute;
            top: 100%; /* Submenú justo debajo del menú principal */
            left: 0;
            background-color: rgba(50, 50, 50, 0.9);
            display: none;
            min-width: 150px;
            z-index: 3;
        }

        /* Mostrar submenú cuando el ratón pasa sobre el menú principal */
        nav ul li:hover > ul {
            display: block;
        }

        nav ul li a {
            text-decoration: none;
            color: white;
            padding: 10px 20px;
            background-color: rgba(0, 0, 0, 0.6);
            border-radius: 5px;
            transition: background-color 0.3s ease;
            display: block;
        }

        nav ul li a:hover {
            background-color: rgba(255, 255, 255, 0.5);
        }

        nav ul ul li a {
            background-color: rgba(50, 50, 50, 0.9);
            padding: 10px;
            display: block;
        }

        /* Estilos para hacer el menú responsivo */
        @media (max-width: 768px) {
            nav ul {
                flex-direction: column;
                align-items: center;
            }

            nav ul li {
                margin: 10px 0;
            }
        }
          /* Estilos adicionales para usuario y cierre de sesión */
        .user-info {
            position: absolute;
            top: 10px;
            right: 10px;
            color: white;
            font-size: 1rem;
            display: flex;
            align-items: center;
        }

        .logout-button {
            margin-left: 10px;
            padding: 5px 10px;
            background-color: #FF4D4D;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <header>
        Menú 
        <div class="user-info">
            <span>Bienvenido, <%= nombreUsuario %>!</span>
            <form action="LogoutServlet" method="post" style="display:inline;">
                <button type="submit" class="logout-button">Cerrar sesión</button>
            </form>
        </div>
    </header>

    <nav>
        <ul>
            <% 
                // Conexión a la base de datos
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_tiendaa", "root", "alexanderlima");

                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM menus WHERE parent_id IS NULL");

                    while (rs.next()) {
                        int parentId = rs.getInt("id");
                        String parentName = rs.getString("name");
                        String parentUrl = rs.getString("url");

                        Statement subMenuStmt = conn.createStatement();
                        ResultSet subMenuRs = subMenuStmt.executeQuery("SELECT * FROM menus WHERE parent_id = " + parentId);

                        if (subMenuRs.next()) {
                            out.println("<li><a href='" + parentUrl + "' target='content-frame'>" + parentName + "</a>");
                            out.println("<ul>");
                            do {
                                String subMenuName = subMenuRs.getString("name");
                                String subMenuUrl = subMenuRs.getString("url");
                                out.println("<li><a href='" + subMenuUrl + "' target='content-frame'>" + subMenuName + "</a></li>");
                            } while (subMenuRs.next());
                            out.println("</ul>");
                            out.println("</li>");
                        } else {
                            out.println("<li><a href='" + parentUrl + "' target='content-frame'>" + parentName + "</a></li>");
                        }

                        subMenuRs.close();
                        subMenuStmt.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </ul>
    </nav>

    <!-- Iframe donde se cargarán los formularios -->
    <iframe id="content-frame" name="content-frame" style="width: 100%; height: calc(100vh - 50px); border: none;"></iframe>
</body>
</html>






