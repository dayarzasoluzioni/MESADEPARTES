<?php

    class Area extends Conectar{

        public function get_area(){

            /* TODO: Obtener la conexión a la base de datos utilizando el método de la clase padre */
            $conectar = parent::conexion();
            /* TODO: Establecer el juego de caracteres a UTF-8 utilizando el método de la clase padre */
            parent::set_names();
            /* TODO: Consulta SQL para insertar un nuevo usuario en la tabla tm_area */
            $sql="SELECT * FROM tm_area
                WHERE est = 1
                ORDER BY area_nom asc";

            /* TODO: Preparar la consulta SQL */
            $sql=$conectar->prepare($sql);
            /* TODO: Ejecutar la consulta SQL */
            $sql->execute();
            return $sql->fetchAll();

        }

    }

?>