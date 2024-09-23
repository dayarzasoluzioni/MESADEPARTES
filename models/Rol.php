<?php

    class Rol extends Conectar{

        public function get_rol(){

            /* TODO: Obtener la conexión a la base de datos utilizando el método de la clase padre */
            $conectar = parent::conexion();
            /* TODO: Establecer el juego de caracteres a UTF-8 utilizando el método de la clase padre */
            parent::set_names();
            /* TODO: Consulta SQL para obtener un registro en la tabla tm_area */
            $sql="SELECT * FROM tm_rol
                WHERE est = 1
                AND ROL_ID not in (1)
                ORDER BY rol_nom asc";

            /* TODO: Preparar la consulta SQL */
            $sql=$conectar->prepare($sql);
            /* TODO: Ejecutar la consulta SQL */
            $sql->execute();
            return $sql->fetchAll();

        }
    }

?>