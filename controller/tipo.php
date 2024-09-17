<?php

    /* TODO: Incluye el archivo de configuración de la conexión a la base de datos y la clase Tipo */
    require_once("../config/conexion.php");
    require_once("../models/Tipo.php");

    /* TODO: Crea una instancia de la clase Tipo */
    $area = new Tipo();

    /* TODO: Utiliza una estructura switch para determinar la operación a realizar según el valor de $_GET["op"] */
    switch($_GET["op"]){

        /* TODO: Si la operación es "combo"" */
        case "combo":

            $datos = $area->get_tipo();
            $html = "";
            $html.="<option value='' disabled selected>Seleccionar</option>";
            if(is_array($datos) == true and count($datos) > 0){

                foreach($datos as $row){

                    $html.="<option value='".$row['tip_id']."'>".$row['tip_nom']."</option>";

                }

                echo $html;

            }

            break;

    }

?>