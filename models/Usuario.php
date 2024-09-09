<?php
    /* TODO: Defeinición de la clase Usuario que se extiende de la clase Conectar */
    class Usuario extends Conectar{

        /* TODO: Método para registrar un nuevo usuario en la base de datos */
        public function registrar_usuario($usu_nomape, $usu_correo, $usu_pass){

            /* TODO: Obtener la conexión a la base de datos utilizando el método de la clase padre */
            $conectar = parent::conexion();
            /* TODO: Establecer el juego de caracteres a UTF-8 utilizando el método de la clase padre */
            parent::set_names();
            /* TODO: Consulta SQL para insertar un nuevo usuario en la tabla tm_usuario */
            $sql="INSERT INTO tm_usuario (usu_nomape, usu_correo, usu_pass) 
                VALUES (?,?,?)";

            /* TODO: Preparar la consulta SQL */
            $sql=$conectar->prepare($sql);
            /* TODO: Vincular los valores a los parámetros de la consulta */
            $sql->bindValue(1,$usu_nomape);
            $sql->bindValue(2,$usu_correo);
            $sql->bindValue(3,$usu_pass);
            /* TODO: Ejecutar la consulta SQL */
            $sql->execute();

        }

        public function get_usuario_correo($usu_correo){

            /* TODO: Obtener la conexión a la base de datos utilizando el método de la clase padre */
            $conectar = parent::conexion();
            /* TODO: Establecer el juego de caracteres a UTF-8 utilizando el método de la clase padre */
            parent::set_names();
            /* TODO: Consulta SQL para insertar un nuevo usuario en la tabla tm_usuario */
            $sql="SELECT * FROM tm_usuario
                WHERE usu_correo = ?";

            /* TODO: Preparar la consulta SQL */
            $sql=$conectar->prepare($sql);
            /* TODO: Vincular los valores a los parámetros de la consulta */
            $sql->bindValue(1,$usu_correo);
            /* TODO: Ejecutar la consulta SQL */
            $sql->execute();
            return $sql->fetchAll();

        }

    }

?>