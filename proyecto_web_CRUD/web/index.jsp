<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        /* Estilos para el cuerpo */
        body {
            font-family: Arial, sans-serif;
            background-color: #1a1a1a; /* Fondo oscuro */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 0;
            background-image: url('images/backgroundlogin.jpg');
            background-size: cover;
            background-position: center; 
            color: white;
        }
        
        /* Estilos para el contenedor del formulario */
        .login-container {
            background-color: rgba(0, 0, 0, 0.7); /* Contenedor oscuro */
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.5); /* Sombra más marcada */
            padding: 30px;
            width: 300px;
            text-align: center;
        }

        /* Estilos para el título */
        .login-container h2 {
            margin-bottom: 20px;
            color: #00A7FF; /* Tono azul */
        }

        /* Estilos para los campos de entrada */
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #007bff; /* Borde azul */
            border-radius: 5px;
            background-color: #333; /* Fondo de entrada oscuro */
            color: #fff; /* Texto blanco */
            box-sizing: border-box;
        }

        /* Estilos para el botón de login */
        .login-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #00A7FF; /* Botón azul */
            border: none;
            border-radius: 5px;
            color: #ffffff;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }

        .login-container input[type="submit"]:hover {
            background-color: #0280C4; /* Hover más oscuro */
        }

        /* Estilos para el enlace */
        .login-container a {
            display: block;
            margin-top: 15px;
            color: #00A7FF; /* Enlace azul */
            text-decoration: none;
        }

        .login-container a:hover {
            text-decoration: underline;
        }

        /* Estilos para el mensaje de error */
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Inicio de sesión</h2>
        <form action="LoginServlet" method="post">
            <input type="text" id="username" name="username" placeholder="Usuario" required>
            <input type="password" id="password" name="password" placeholder="Contraseña" required>
            <input type="submit" value="Ingresar">
        </form>
        <a href="registro_usuario.jsp">Registrarse</a>

        <!-- Mensaje de error -->
        <div id="error-message" class="error-message">
            <!-- Aquí se insertará el mensaje de error si hay un error -->
            <script>
                // Obtener el parámetro 'error' de la URL
                const urlParams = new URLSearchParams(window.location.search);
                const error = urlParams.get('error');

                // Si hay un error, mostrar el mensaje correspondiente
                if (error) {
                    let errorMessage = document.getElementById('error-message');
                    if (error === '1') {
                        errorMessage.textContent = 'Usuario o contraseña incorrectos. Intente de nuevo.';
                    } else if (error === '2') {
                        errorMessage.textContent = 'Error de conexión a la base de datos. Intente más tarde.';
                    }
                }
            </script>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>


