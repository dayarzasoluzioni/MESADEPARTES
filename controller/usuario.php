<?php
    /* TODO: Incluye el archivo de configuración de la conexión a la base de datos y la clase Usuario */
    require_once("../config/conexion.php");
    require_once("../models/Usuario.php");

    /* TODO: Crea una instancia de la clase Usuario */
    $usuario = new Usuario();

    /* TODO: Utiliza una estructura switch para determinar la operación a realizar según el valor de $_GET["op"] */
    switch($_GET["op"]){

        /* TODO: Si la operación es Registrar */
        case "registrar":
            /* TODO: Llama al método registrar_usuario de la instancia $usuario con los datos del formulario */
            $usuario->registrar_usuario($_POST["usu_nomape"], $_POST["usu_correo"], $_POST["usu_pass"]);
            break;

    }

?>