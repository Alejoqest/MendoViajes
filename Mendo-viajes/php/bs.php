<?php
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

    public function Select(String $table, array $where) : array {
        $sql = "SELECT `numVuelo`, `destino`, `clase`, `equipaje`, `fechaVuelo`, `horaVuelo`, `duracionVuelo`, `precioPer` FROM `$table` WHERE ";
        $i = 0;
        foreach ($where as $key => $val) {
            if ($i > 0) {
                $sql .= "AND ";
            }
            if ($key == "fechaVuelo") {
                $val = strtotime($val);
                $val = date('Y-m-d');
            }
            $sql .="`$key`='$val' ";
            $i++;
        }
        $sql .= "ORDER BY `precioPer`;";
        $result = mysqli_query($this->conn, $sql);
        file_put_contents("sql_log.txt", $sql."\n");
        $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
        return $rows;
    }
}
?>