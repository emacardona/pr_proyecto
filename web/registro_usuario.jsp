<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuario</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: rgba(0, 0, 0, 0.5); /* Fondo oscuro */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;

            margin: 0;
            padding: 0;
            height: 100vh; /* Hace que el fondo cubra toda la ventana */
            background-image: url('images/backgroundlogin.jpg'); /* Ruta a tu imagen */
            background-size: cover; /* Hace que la imagen cubra todo el fondo */
            background-position: center; /* Centra la imagen */
            color: white; /* Color del texto */

        }

        
        .register-container {
            background-color: rgba(0, 0, 0, 0.7); /* Fondo oscuro */
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            padding: 30px;
            width: 300px;
            text-align: center;
            color: white; /* Texto en blanco */
        }

        .register-container h2 {
            margin-bottom: 20px;
            color: white; /* Color del texto */
        }

        .register-container input[type="text"],
        .register-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid rgba(255, 255, 255, 0.5); /* Borde claro */
            border-radius: 5px;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.1); /* Fondo translúcido */
            color: white; /* Texto blanco */
        }

        .register-container input[type="text"]::placeholder,
        .register-container input[type="password"]::placeholder {
            color: rgba(255, 255, 255, 0.7); /* Placeholder en blanco opaco */
        }

        .register-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: rgba(0, 0, 0, 0.8); /* Color oscuro */
            border: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .register-container input[type="submit"]:hover {
            background-color: rgba(0, 0, 0, 0.6); /* Efecto hover */
        }

        .register-container input[type="text"]:focus,
        .register-container input[type="password"]:focus {
            border-color: #ff6347; /* Color de foco como el del menú */
            outline: none;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Registro de Usuario</h2>
        <form action="RegisterServlet" method="post">
            <input type="text" name="username" placeholder="Nombre de usuario" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <input type="submit" value="Registrar">
           <a href="index.jsp">Regresar</a>
        </form>
    </div>
</body>
</html>

