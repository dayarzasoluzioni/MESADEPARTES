<?php
    /* TODO: Defeinición de la clase Documento que se extiende de la clase Conectar */
    class Documento extends Conectar{

        /* TODO: Método para registrar un nuevo usuario en la base de datos */
        public function registrar_documento($area_id, $tra_id, $doc_externo, $tip_id, $doc_dni, $doc_nom, $doc_descrip, $usu_id){

            /* TODO: Obtener la conexión a la base de datos utilizando el método de la clase padre */
            $conectar = parent::conexion();
            /* TODO: Establecer el juego de caracteres a UTF-8 utilizando el método de la clase padre */
            parent::set_names();
            /* TODO: Consulta SQL para insertar un nuevo usuario en la tabla tm_documento */
            $sql="INSERT INTO tm_documento 
                (area_id, tra_id, doc_externo, tip_id, doc_dni, doc_nom, doc_descrip, usu_id) 
                VALUES 
                (?,?,?,?,?,?,?,?)";

            /* TODO: Preparar la consulta SQL */
            $sql=$conectar->prepare($sql);
            /* TODO: Vincular los valores a los parámetros de la consulta */
            $sql->bindValue(1,$area_id);
            $sql->bindValue(2,$tra_id);
            $sql->bindValue(3,$doc_externo);
            $sql->bindValue(4,$tip_id);
            $sql->bindValue(5,$doc_dni);
            $sql->bindValue(6,$doc_nom);
            $sql->bindValue(7,$doc_descrip);
            $sql->bindValue(8,$usu_id);

            /* TODO: Ejecutar la consulta SQL */
            $sql->execute();

            $sql1 = "select last_insert_id() as 'doc_id'";
            $sql1=$conectar->prepare($sql1);
            $sql1->execute();

            return $sql1->fetchAll(pdo::FETCH_ASSOC);

        }

    }

?>