<?php

    require '../include/vendor/autoload.php';

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;

    require_once("../config/conexion.php");
    require_once("../models/Usuario.php");

    class Email extends PHPMailer{

        protected $gCorreo = 'notificacion-mesadepartes@soluzioni.com.pe';
        protected $gContrasena = 'yfrB4cct-0Pj';

        private $key = "MesaDePartesSoluzioni";
        private $cipher = "aes-256-cbc";

        public function registrar($usu_id){

            $conexion = new Conectar();

            $usuario = new Usuario();
            $datos = $usuario ->get_usuario_id($usu_id);

            $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
            $cifrado = openssl_encrypt($usu_id, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv);
            $textoCifrado = base64_encode($iv . $cifrado);

            $this->IsSMTP();
            $this->Host = 'mail.soluzioni.com.pe';

            // Usa el puerto correcto para SSL
            $this->Port = 465; // Puerto SSL
            $this->SMTPAuth = true;
            $this->SMTPSecure = 'ssl'; // Conexión SSL/TLS desde el inicio

            $this->Username = $this->gCorreo;
            $this->Password = $this->gContrasena;
            $this->setFrom($this->gCorreo,"Registro en Mesa de Partes Soluzioni Group");

            $this->CharSet = 'UTF8';
            /* $this->addAddress($usu_correo); */
            $this->addAddress($datos[0]["usu_correo"]);
            $this->IsHTML(true);
            $this->Subject = "Mesa de Partes";

            $url = $conexion->ruta() . "view/confirmar/?id=" . $textoCifrado;

            $cuerpo = file_get_contents("../assets/email/registrar.html");
            $cuerpo = str_replace("xlinkcorreourl", $url, $cuerpo);

            $this->Body = $cuerpo;
            $this->AltBody = strip_tags("Confirmar Registro");

            try{
                $this->send();
                return true;
            }catch(Exception $e){
                return false;
            }

        }

    }

?>