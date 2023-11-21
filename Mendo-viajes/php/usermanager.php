<?php
require_once "bs.php";
switch($_SERVER["REQUEST_METHOD"]) {
    case "GET":
        $result = [];
        if (!empty($_SESSION["id"])) {
            $result = ["datos"=> array("id" => $_SESSION["id"], 
            "username" => $_SESSION["username"], "type" => $_SESSION["type"], 
            "email" => $_SESSION["email"]), "acount_status" => "En sesión."];
        } else {
            $result = ["datos" => array("id"=>0), "acount_status" => "Registrate o inicia sesión."];
        }
        echo (json_encode($result));
        break;
}
?>