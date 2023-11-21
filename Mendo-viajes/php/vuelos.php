<?php
/*CREATE TABLE `mendoviajes`.`viajes ida` 
(`numVuelo` BIGINT(8) NOT NULL ,
`destino` ENUM('miami','nueva-york','fort-lauderdale','los-angeles','orlando','montreal','toronto','vancouver','mexico','buenos-aires','madrid','barcelona','londres','frankfurt','berlin','paris','roma','milan','tokio','shanghai') NULL , 
`clase` ENUM('economica','premium','ejecutiva','primera') NOT NULL , 
`equipaje` ENUM('sin equipaje','permitido') NOT NULL , 
`fechaVuelo` DATE NULL , `horaVuelo` TIME NOT NULL , 
`duracionVuelo` TIME NOT NULL , 
`precioPer` DOUBLE(255,5) NOT NULL , 
PRIMARY KEY (`numVuelo`)) ENGINE = InnoDB;*/
require "bs.php";
header('Access-Control-Allow-Origin: null');
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: DELETE, GET, OPTIONS, POST, PUT');
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Sat, 26 Jul 1917 05:00:00 GMT");
header("Pragma: no-cache");
const BDNOMBRE = "mendoviajes";
const BDUSER = "root";
const BDPASS = "";
const FLOORVALUESFLYINOUT = 4;
switch($_SERVER["REQUEST_METHOD"]) {
    case 'GET':
        $table = "viajesida";
        $_SERVER["vuelta"] = false;
        if (isset($_SERVER["more"])) {unset($_SERVER["more"]);};
        $result = [];
        parse_str($_SERVER["QUERY_STRING"], $_SELECT);
        if (count($_SELECT) >= FLOORVALUESFLYINOUT) {
            $_SERVER["vuelta"] = true;
            $table = "vuelosidayvuelta";
        }
        if(isset($_SELECT["modalidad"])) {
            if($_SELECT["modalidad"] == "vue") {
                $_SERVER["vuelta"] = true;
                $table = "vuelosidayvuelta";
            }
            unset($_SELECT["modalidad"]);
            $_SERVER["more"] = true;
        }
        try{
            $bd = new BD(BDUSER, BDPASS, BDNOMBRE);
            $result += ['datos' => $bd->Select($table, $_SERVER["vuelta"], $_SELECT)];
        } catch (mysqli_sql_exception $mysqle) {
            error_log($mysqle->__toString()."\n", 3, "mysqlierror.txt");
            http_response_code(404);
            $result += ['error' => "No se pudo leer los datos."];
        } finally {
            $result += ['status' => http_response_code()];
            $result += ['vuelta' => $_SERVER["vuelta"]];
            $result += ['cont' => $_SELECT];
            echo json_encode($result);
        }
    break;
    case 'POST':
        $result = [];
        $table = "reservasvuelosida";
        parse_str(file_get_contents("php://input"), $_INSERT);
        if (count($_INSERT) >= FLOORVALUESFLYINOUT) {
            $table = "reservasvuelosvuelta";
        }
        try {
            $bd = new BD(BDUSER, BDPASS, BDNOMBRE);
            $result += ['resultado' => $bd->Insertreserve($table, $_INSERT)];
            http_response_code(201);
        } catch (mysqli_sql_exception $mysqle) {
            error_log($mysqle->__toString()."\n", 3, "mysqlierror.txt");
            http_response_code(404);
            $result += ['error' => "No se pudo hacer la reservacion"];
        } finally {
            $result += ['status' => http_response_code()];
            $result += ['cont' => $_INSERT];
            echo json_encode($result);
        }
    break;
}
?>