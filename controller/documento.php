<?php
    /* TODO: Incluye el archivo de configuración de la conexión a la base de datos y la clase Documento */
    require_once("../config/conexion.php");
    require_once("../models/Documento.php");
    require_once("../models/Email.php");

    /* TODO: Crea una instancia de la clase Documento */
    $documento = new Documento();
    $email = new Email();

    /* TODO: Utiliza una estructura switch para determinar la operación a realizar según el valor de $_GET["op"] */
    switch($_GET["op"]){

        /* TODO: Si la operación es Registrar */
        case "registrar":
            /* TODO: Llama al método registrar_usuario de la instancia $usuario con los datos del formulario */
            $datos = $documento->registrar_documento(
                $_POST["area_id"], 
                $_POST["tra_id"], 
                $_POST["doc_externo"], 
                $_POST["tip_id"], 
                $_POST["doc_dni"], 
                $_POST["doc_nom"],
                $_POST["doc_descrip"], 
                $_SESSION["usu_id"]
            );            

            if(is_array($datos) == true and count($datos) == 0){                
                
                echo "0";

            }else{
                
                $mes = date("m");
                $anio = date("Y");

                echo $mes ."-". $anio . "-" . $datos[0]["doc_id"];

                if(empty($_FILES['file']['name'])){

                }else{
                    $countfiles = count($_FILES['file']['name']);
                    $ruta = "../assets/document/".$datos[0]["doc_id"]."/";
                    $file_arr = array();

                    if(!file_exists($ruta)){
                        mkdir($ruta, 0777, true);
                    }

                    for($index = 0; $index < $countfiles; $index++){

                        $nombre = $_FILES['file']['tmp_name'][$index];
                        $destino = $ruta.$_FILES['file']['name'][$index];

                        $documento->insert_documento_detalle($datos[0]["doc_id"], $_FILES['file']['name'][$index], $_SESSION["usu_id"]);

                        move_uploaded_file($nombre, $destino);

                    }

                    /* TODO: Enviar Alerta por Email */
                    $email->enviar_registro($datos[0]["doc_id"]);
                }

            }
            
            break;

        /* TODO: Listado de usuario segun formato json para el datatable */
        case "listarusuario":

            $datos = $documento->get_documento_x_usu($_SESSION["usu_id"]);
            $data = Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["nrotramite"];
            }

            break;

    }

?>