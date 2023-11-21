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
    <title>Registrar</title>
</head>
<body>
    <?php
    function ptag(string $string) {
        return ("<p>". $string ."</p>");
    }
    if (isset($_POST["register-account"])) {
        $username = filter_var($_POST["username-account"], FILTER_SANITIZE_SPECIAL_CHARS);
        $password = filter_var($_POST["password-account"], FILTER_SANITIZE_SPECIAL_CHARS);
        $password_repeat = filter_var($_POST["password-repeat"], FILTER_SANITIZE_SPECIAL_CHARS);
        $email = filter_var($_POST["email-account"], FILTER_SANITIZE_EMAIL);
        
        if ($password !== $password_repeat) {
            echo ptag("MAL");
        } else {
            echo ptag("BIEN");
            $password = password_hash($password, PASSWORD_DEFAULT);
            $param = array($username, $password, $email);
            $bd = new BD(BDUSER, BDPASS, BDNOMBRE);
            echo $bd->register($param);
        }
    }
    ?>
    <form action="register.php" method="post">
        <label for="username-input">Ingrese su nombre de usuario: </label> <br>
        <input type="text" name="username-account" id="username-input" required> <br>
        <label for="password-input">Ingrese su contraseña de la cuenta: </label> <br>
        <input type="password" name="password-account" id="password-input" required> <br>
        <label for="password-input-repeat">Repita su contraseña que ingreso: </label> <br>
        <input type="password" name="password-repeat" id="password-input-repeat" required> <br>
        <label for="email-input">Ingrese su email:</label> <br>
        <input type="email" name="email-account" id="email-input" pattern="^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$" required> <br>
        <input type="submit" name="register-account" value="Registrate">
    </form>
    <a href="login.php">Si tenes cuenta, inicia sesion!</a>
</body>
</html>