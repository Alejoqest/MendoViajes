<?php
/*include "bs.php";*/
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
$url = array("fechaVuelo"=>"2023-11-01", "clase" => "economica");
echo (json_encode($url));

class BD {
    protected $conn;
    function __construct( 
        String $db_username, 
        String $db_password, 
        String $db_name
    ) {
        $result = []; 
        try {
            $this->conn = mysqli_connect("localhost", $db_username, $db_password, $db_name);
        } catch (mysqli_sql_exception) {
            $result += ['Error'. mysqli_connect_errno() .'#'=> mysqli_connect_error()];
        } finally {
            $result += ['status' => http_response_code()];
            json_encode($result);
        }
    }

    function __destruct() {
        mysqli_close($this->conn); 
    }

    function armarWhere(array $where, String $tipo) : String {
        switch ($tipo) {
            case "AND":
                $callback = fn($k, $v) => "`$k` = '$v'";
                $sql = implode(" AND ", array_map($callback, array_keys($where), array_values($where)));
            break;
        }
        return $sql;
    }

    public function Select(String $table, bool $vuelta , array $where){
        $sql = "SELECT `numVuelo`, `destino`, `clase`, `equipaje`, `fechaVuelo`, `horaVuelo`, `duracionVuelo`, `precioPer` FROM `$table` WHERE ";
        if ($vuelta = true) {

        }
        $sql .= $this->armarWhere($where, "AND");
        $sql .= " ORDER BY `precioPer`;";
        try {
        $result = mysqli_query($this->conn, $sql);
        file_put_contents("sql_log.txt", $sql."\n");
        $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
        $result = ['datos' => $rows, 'sql' => $sql]; }
        catch (mysqli_sql_exception) {
        $result = [mysqli_errno($this->conn) => mysqli_error($this->conn), 'sql' => $sql];
    }
        return json_encode($result);
    }
}
$bd = new BD(BDUSER, BDPASS, BDNOMBRE);

    echo ($bd->Select("viajes ida", false, $url));

/*$i = 0;
foreach ($where as $key => $val) {
    if ($i > 0) {
        $sql .= "AND ";
    }
    $sql .="`$key`='$val' ";
    $i++;
}
*/

/*$result = [];
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
    */
?>