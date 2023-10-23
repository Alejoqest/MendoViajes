<?php
include "bs.php";
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
$url = "fechaVuelo=2023-11-01";
$result = [];
    parse_str($url, $_SELECT);
    try{
        $bd = new BD(BDUSER, BDPASS, BDNOMBRE);
        $result += ['datos' => $bd->Select("viajes ida", $_SELECT)];
    } catch (mysqli_sql_exception $mysqle) {
        error_log($mysqle->__toString()."\n", 3, "mysqlierror.txt");
        http_response_code(404);
        $result += ['error' => "No se pudo leer los datos."];
    } finally {
        $result += ['status' => http_response_code()];
        $result += ['cont' => $_SELECT];
        echo json_encode($result);
    }
?>