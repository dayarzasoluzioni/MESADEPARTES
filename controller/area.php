<?php

    /* TODO: Incluye el archivo de configuración de la conexión a la base de datos y la clase Area */
    require_once("../config/conexion.php");
    require_once("../models/Area.php");

    /* TODO: Crea una instancia de la clase Area */
    $area = new Area();

    /* TODO: Utiliza una estructura switch para determinar la operación a realizar según el valor de $_GET["op"] */
    switch($_GET["op"]){

        /* TODO: Si la operación es "combo"" */
        case "combo":

            $datos = $area->get_area();
            $html = "";
            $html.="<option value='' disabled selected>Seleccionar</option>";
            if(is_array($datos) == true and count($datos) > 0){

                foreach($datos as $row){

                    $html.="<option value='".$row['area_id']."'>".$row['area_nom']."</option>";

                }

                echo $html;

            }

            break;

    }

?>