<%
    // Verificar si el usuario ha iniciado sesión
    String nombreUsuario = (String) session.getAttribute("nombreUsuario");
    if (nombreUsuario == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú Dinámico</title>
    <style>
        /* Tu estilo de menú */
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
            position: relative;
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
            top: 100%;
            left: 0;
            background-color: rgba(50, 50, 50, 0.9);
            display: none;
            min-width: 150px;
            z-index: 3;
        }
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
        @media (max-width: 768px) {
            nav ul {
                flex-direction: column;
                align-items: center;
            }
            nav ul li {
                margin: 10px 0;
            }
        }
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
        Menú Principal.
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
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_tienda", "root", "kevinlima");

                    // Consulta para obtener todos los menús
                    String query = "SELECT * FROM menus";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    // Mapa para almacenar los menús principales y sus submenús
                    HashMap<Integer, ArrayList<String[]>> menuMap = new HashMap<>();

                    // Procesar los resultados
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String url = rs.getString("url");
                        int parentId = rs.getInt("parent_id");

                        // Si es un menú principal, lo añadimos como clave
                        if (parentId == 0) {
                            menuMap.put(id, new ArrayList<>());
                        } else {
                            // Añadir submenús
                            if (!menuMap.containsKey(parentId)) {
                                menuMap.put(parentId, new ArrayList<>());
                            }
                            menuMap.get(parentId).add(new String[]{name, url});
                        }
                    }

                    // Generar el menú principal con submenús
                    for (Integer parentId : menuMap.keySet()) {
                        // Obtener el nombre y URL del menú principal
                        String parentQuery = "SELECT name, url FROM menus WHERE id = ?";
                        PreparedStatement parentStmt = conn.prepareStatement(parentQuery);
                        parentStmt.setInt(1, parentId);
                        ResultSet parentRs = parentStmt.executeQuery();

                        if (parentRs.next()) {
                            String parentName = parentRs.getString("name");
                            String parentUrl = parentRs.getString("url");

                            // Mostrar el menú principal
                            out.println("<li><a href='" + parentUrl + "' target='content-frame'>" + parentName + "</a>");

                            // Mostrar submenús si existen
                            ArrayList<String[]> subMenus = menuMap.get(parentId);
                            if (!subMenus.isEmpty()) {
                                out.println("<ul>");
                                for (String[] subMenu : subMenus) {
                                    String subMenuName = subMenu[0];
                                    String subMenuUrl = subMenu[1];
                                    out.println("<li><a href='" + subMenuUrl + "' target='content-frame'>" + subMenuName + "</a></li>");
                                }
                                out.println("</ul>");
                            }
                            out.println("</li>");
                        }

                        parentRs.close();
                        parentStmt.close();
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







