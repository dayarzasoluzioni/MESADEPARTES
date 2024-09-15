<?php

    /* TODO: Incluye el archivo de configuración de la conexión a la base de datos y la clase Tramite */
    require_once("../config/conexion.php");
    require_once("../models/Tramite.php");

    /* TODO: Crea una instancia de la clase Tramite */
    $tramite = new Tramite();

    /* TODO: Utiliza una estructura switch para determinar la operación a realizar según el valor de $_GET["op"] */
    switch($_GET["op"]){

        /* TODO: Si la operación es "combo"" */
        case "combo":

            $datos = $tramite->get_tramite();
            $html = "";
            $html.="<option value='' disabled selected>Seleccionar</option>";
            if(is_array($datos) == true and count($datos) > 0){

                foreach($datos as $row){

                    $html.="<option value='".$row['tra_id']."'>".$row['tra_nom']."</option>";

                }

                echo $html;

            }

            break;

    }

?>