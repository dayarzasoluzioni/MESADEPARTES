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
                echo json_encode($datos);
            }else{
                echo "0";
            }
            
            break;

        

            if($_SERVER["REQUEST_METHOD"] == "POST" && $_SERVER["CONTENT_TYPE"] === "application/json"){
                /* TODO: Recuperar el JSON del cuerpo POST */
                $jsonStr = file_get_contents('php://input');
                $jsonObj = json_decode($jsonStr);

                if(!empty($jsonObj->request_type) && $jsonObj->request_type == 'user_auth'){

                    $credential = !empty($jsonObj->credential) ? $jsonObj->credential : '';

                    /* TODO: Decodificar el payload de la respuesta desde el token JWT */
                    $parts = explode(".", $credential);
                    $header = base64_decode($parts[0]);
                    $payload = base64_decode($parts[1]);
                    $signature = base64_decode($parts[2]);

                    $reponsePayload = json_decode($payload);

                    if(!empty($reponsePayload)){

                        /* TODO: Informacion del perfil del usuario */
                        $nombre = !empty($reponsePayload->name) ? $reponsePayload->name : '';
                        $email = !empty($reponsePayload->email) ? $reponsePayload->email : '';
                        $imagen = !empty($reponsePayload->picture) ? $reponsePayload->picture : '';

                    }

                    $datos = $usuario->get_usuario_correo($email);

                    if(is_array($datos) == true and count($datos) == 0){

                        $datos1 = $usuario->registrar_usuario($nombre, $email, "", $imagen, 1);

                        $_SESSION["usu_id"] = $datos1[0]["usu_id"];
                        $_SESSION["usu_nomape"] = $nombre;                        
                        $_SESSION["usu_correo"] = $email;
                        $_SESSION["usu_img"] = $imagen;

                        echo "1";

                    }
                    else{

                        $usu_id = $datos[0]["usu_id"];

                        $_SESSION["usu_id"] = $usu_id;
                        $_SESSION["usu_nomape"] = $nombre;                        
                        $_SESSION["usu_correo"] = $email;
                        $_SESSION["usu_img"] = $imagen;

                        echo "0";

                    }

                    
                }else{

                    echo json_encode(
                        [
                            'error' => 'Los datos de la cuenta no están disponibles'
                        ]
                    );

                }
            }

            break;

    }

?>