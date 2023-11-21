<?php
session_start();
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

    
    public function Select(String $table, bool $vuelta , array $where) : array {
        if ($vuelta == true) {
            if (isset($_SERVER["more"])) {
                $sql = "SELECT `vuelta`.`clase`, `vuelta`.`equipaje`, ".
                "`vuelta`.`precioPer` ".
                "FROM `vuelosvuelta` `vuelta` WHERE ";
                foreach ($where as $key => $var) {
                    $sql .= "`vuelta`.`$key` = '$var'";
                }
                $result = mysqli_query($this->conn, $sql);
                file_put_contents("sql_log.txt", $sql."\n");
                $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
                return $rows;
            }
            $counter = 0;
            $sql = "SELECT `ida`.`id` `idaId`, `ida`.`numVuelo`, ".
            "CONCAT(`ida`.`fechaVuelo`, 'T', `ida`.`horaVuelo`) `fechaVuelo`, ".
            "`ida`.`duracionVuelo`,`vuelta`.`id`, ".
            "`vuelta`.`numVuelta`, CONCAT(`vuelta`.`fechaVuelta`, 'T', `vuelta`.`horaVuelta`) `fechaVuelta`, ".
            "`vuelta`.`duracionVuelta`, ".
            "`vuelta`.`precioPer` + `ida`.`precioPer` `precioPer` ".
            "FROM `vuelosvuelta` `vuelta` ".
            "LEFT JOIN `viajesida` `ida` ".
            "ON `vuelta`.`ubicacion` = `ida`.`destino` WHERE ";
            
            foreach ($where as $key => $var) {
                if ($counter < 2) {
                    $sql .= "`vuelta`.`$key` = '$var'";
                } else {
                    $sql .= "`ida`.`$key` = '$var'";
                }
                if ($counter < 3) {
                    $sql .= " AND ";
                }
                $counter ++;
            }
            
            $sql .= " ORDER BY `precioPer`;"/* LIMIT 10;"*/;
            //return array($sql);
            $result = mysqli_query($this->conn, $sql);
            file_put_contents("sql_log.txt", $sql."\n");
            $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
            return $rows;
        }
        $sql = "SELECT `id`, `numVuelo`, `destino`, `clase`, `equipaje`, `fechaVuelo`, `horaVuelo`, `duracionVuelo`, `precioPer` FROM `$table` WHERE ";
        if (isset($_SERVER["more"])) {
            $sql = "SELECT `clase`, `equipaje`, `precioPer` FROM `viajesida` WHERE ";
        }
        $sql .= $this->armarWhere($where, "AND");
        $sql .= " ORDER BY `precioPer`;";
        $result = mysqli_query($this->conn, $sql);
        file_put_contents("sql_log.txt", $sql."\n");
        $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
        return $rows;
    }
    
    function login(String $username, String $password) {
        $sql = "SELECT `id`, `username`, `password`, `email`, `type`, `regdate` FROM `usuario` WHERE `username`= '$username';";
        $result = mysqli_query($this->conn, $sql);
        $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
        if (count($rows) <= 0) {
            return("Tu cuenta no existe.");
        } else {
            if (!password_verify($password, $rows[0]["password"])) {
                return("La contraseña esta equivocada.");
            } else {
                $_SESSION["username"] = $username;
                $_SESSION["id"] = $rows[0]["id"];
                $_SESSION["email"] = $rows[0]["email"];
                $_SESSION["type"] = $rows[0]["type"];
                return("Se ha iniciado sesion. <br> Hola ". $_SESSION["username"]. "!");
            }
        }
    }
    
    function register(array $param) {
        $sql = "INSERT INTO `usuario`(`username`, `password`, `email`) VALUES ('". implode("', '", $param) ."');";
        mysqli_query($this->conn, $sql);
        return ("Registrado correctamente.");
    }

    function Insertreserve(string $table, array $param) {
        $counter = 0;
        $sql_select = "SELECT `". implode("`, `", array_keys($param)) ."` FROM `$table` ".
        "WHERE ";
        foreach ($param as $key => $val) {
            if ($key == "vueloId" ) {
                $sql_select .= "`$key` = '$val' ";
            }
            if ($key == "vueloIdaId" || $key == "vueloVueltaId") {
                $sql_select .= "`$key` = '$val' ";
                if ($counter == 0 && $counter <1) {
                    $sql_select .= "AND ";
                }
            }
            $counter++;
        }
        //return ($sql_select);
        $result = mysqli_query($this->conn, $sql_select);
        file_put_contents("sql_log.txt", $sql_select."\n");
        if (count(mysqli_fetch_all($result, MYSQLI_ASSOC)) >= 1) {
            return ("Ya habias reservado este vuelo.");
        }
        $sql = "INSERT INTO `$table`(`userid`, `". implode("`, `", array_keys($param)) ."`) VALUES ('".$_SESSION['id']."', '". implode("', '", $param) ."');";
        //return ($sql);
        mysqli_query($this->conn, $sql);
        return ("Reserva hecha correctamente.");
    }

    function Logoff() {session_destroy();}
    
    function armarWhere(array $where, String $tipo) : String {
        switch ($tipo) {
            case "AND":
                $sql = implode(" $tipo ", array_map(fn($k, $v) => "`$k` = '$v'", array_keys($where), array_values($where)));
            break;
        }
        return $sql;
    }
}
?>