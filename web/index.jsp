<%-- 
    Document   : index.jsp
    Created on : 28/10/2024, 9:21:29 p. m.
    Author     : Josee
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generar Reportes en PDF</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"> <!-- Fuente Roboto -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(to right, #4facfe, #00f2fe); /* Gradiente de fondo */
            color: #333;
            position: relative;
        }
        .container {
            text-align: center;
            background: #ffffff;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 90%;
            transition: transform 0.3s; /* Transición suave */
        }
        .container:hover {
            transform: translateY(-5px); /* Efecto de elevación */
        }
        h1 {
            font-size: 2em; /* Tamaño de fuente aumentado */
            color: #333;
            margin-bottom: 1.5rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1); /* Sombra del texto */
        }
        .pdf-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .pdf-links li {
            margin: 1rem 0; /* Espaciado aumentado */
        }
        .pdf-links a {
            display: inline-block;
            text-decoration: none;
            color: #ffffff;
            background-color: #007BFF;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            font-size: 1.1em; /* Tamaño de fuente aumentado */
            transition: background-color 0.3s ease, transform 0.2s; /* Transición suave */
        }
        .pdf-links a:hover {
            background-color: #0056b3;
            transform: scale(1.05); /* Efecto de crecimiento al pasar el mouse */
        }
        /* Estilos para pantallas pequeñas */
        @media (max-width: 600px) {
            h1 {
                font-size: 1.5em; /* Tamaño de fuente ajustado */
            }
            .pdf-links a {
                font-size: 1em; /* Tamaño de fuente ajustado */
                padding: 0.5rem 1rem; /* Espaciado ajustado */
            }
        }
    </style>
    <script>
        function generatePDF(tipo) {
            // Redirigir a la URL del PDF
            window.location.href = '${pageContext.request.contextPath}/pdfgenerator?tipo=' + tipo;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Generar Reportes en PDF</h1>
        <ul class="pdf-links">
            <li>
                <a href="javascript:void(0);" onclick="generatePDF('clientes')">PDF de Clientes</a>
            </li>
            <li>
                <a href="javascript:void(0);" onclick="generatePDF('productos')">PDF de Productos</a>
            </li>
            <li>
                <a href="javascript:void(0);" onclick="generatePDF('ventas')">PDF de Ventas</a>
            </li>
        </ul>
    </div>
</body>
</html>
