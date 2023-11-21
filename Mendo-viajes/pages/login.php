<?php
require_once "../php/bs.php";
const BDNOMBRE = "mendoviajes";
const BDUSER = "root";
const BDPASS = "";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesion</title>
</head>
<body>
    <?php
    if (isset($_POST["login-account"])) {
        $nombre = filter_var($_POST["username-account"], FILTER_SANITIZE_SPECIAL_CHARS);
        $contrasena = filter_var($_POST["password-account"], FILTER_SANITIZE_SPECIAL_CHARS);
        $user = new BD(BDUSER, BDPASS, BDNOMBRE);
        echo "<p>". $user->login($nombre, $contrasena) ."</p>";
    }
    ?>
    <form action="login.php" method="POST">
        <label for="username-input">Ingrese nombre de usuario: </label> <br>
        <input type="text" name="username-account" id="username-input"> <br>
        <label for="password-input">Ingrese su contraseña: </label> <br>
        <input type="password" name="password-account" id="password-input"> <br>
        <input type="submit" name="login-account" value="Inicia sesion">
    </form>
    <?php
    echo "<div>";
    if (empty($_SESSION["id"])) {
        echo '<a href="register.php">
        Si no tenes cuenta registrate!
        </a>';
    } else {
        echo '<a href="service.html">
        Mira que tipo de vuelos puedes acceder!
        </a>';
    }
    echo "</div>"
    ?>
</body>
</html>