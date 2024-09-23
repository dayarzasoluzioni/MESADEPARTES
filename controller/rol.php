<?php

    /* TODO: Incluye el archivo de configuración de la conexión a la base de datos y la clase Rol */
    require_once("../config/conexion.php");
    require_once("../models/Rol.php");

    /* TODO: Crea una instancia de la clase Rol */
    $rol = new Rol();

    /* TODO: Utiliza una estructura switch para determinar la operación a realizar según el valor de $_GET["op"] */
    switch($_GET["op"]){

        /* TODO: Si la operación es "combo"" */
        case "combo":

            $datos = $rol->get_rol();
            $html = "";
            $html.="<option value='' disabled selected>Seleccionar</option>";
            if(is_array($datos) == true and count($datos) > 0){

                foreach($datos as $row){

                    $html.="<option value='".$row['rol_id']."'>".$row['rol_nom']."</option>";

                }

                echo $html;

            }

            break;

    }
    
?>