<?php

    require '../include/vendor/autoload.php';

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;

    require_once("../config/conexion.php");
    require_once("../models/Usuario.php");
    require_once("../models/Documento.php");

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
            $this->setFrom($this->gCorreo,"Registro en Mesa de Partes Soluzioni Capital");

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

        public function recuperar($usu_correo, $rol_id){

            $conexion = new Conectar();

            $usuario = new Usuario();
            $datos = $usuario ->get_usuario_correo($usu_correo);

            /* $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
            $cifrado = openssl_encrypt($usu_id, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv);
            $textoCifrado = base64_encode($iv . $cifrado); */

            $this->IsSMTP();
            $this->Host = 'mail.soluzioni.com.pe';

            // Usa el puerto correcto para SSL
            $this->Port = 465; // Puerto SSL
            $this->SMTPAuth = true;
            $this->SMTPSecure = 'ssl'; // Conexión SSL/TLS desde el inicio

            $this->Username = $this->gCorreo;
            $this->Password = $this->gContrasena;
            $this->setFrom($this->gCorreo,"Recuperar Contraseña en Mesa de Partes Soluzioni Capital");

            $this->CharSet = 'UTF8';
            /* $this->addAddress($usu_correo); */
            $this->addAddress($datos[0]["usu_correo"]);
            $this->IsHTML(true);
            $this->Subject = "Mesa de Partes";

            if($rol_id == 1){

                $url = $conexion->ruta();

            }elseif($rol_id == 2){

                $url = $conexion->ruta()."view/accesopersonal/";

            }            

            /* TODO: Generar la cadena alfanmérica */
            $xpassusu = $this->generarXPassUsu();

            $usuario -> recuperar_usuario($usu_correo, $xpassusu);

            $cuerpo = file_get_contents("../assets/email/recuperar.html");
            $cuerpo = str_replace("xpassusu", $xpassusu, $cuerpo);
            $cuerpo = str_replace("xlinksistema", $url, $cuerpo);

            $this->Body = $cuerpo;
            $this->AltBody = strip_tags("Recuperar Contraseña");

            try{
                $this->send();
                return true;
            }catch(Exception $e){
                return false;
            }

        }

        private function generarXPassUsu(){

            $parteAlfanumerica = substr(md5(rand()), 0, 3);
            $parteNumerica = str_pad(rand(0,999), 3, '0', STR_PAD_LEFT);
            $resultado = $parteAlfanumerica . $parteNumerica;
            return substr($resultado,0,6);

        }

        public function enviar_registro($doc_id){

            $conexion = new Conectar();

            $documento = new Documento();
            $datos = $documento ->get_documento_x_id($doc_id);

            /* $iv = openssl_random_pseudo_bytes(openssl_cipher_iv_length($this->cipher));
            $cifrado = openssl_encrypt($usu_id, $this->cipher, $this->key, OPENSSL_RAW_DATA, $iv);
            $textoCifrado = base64_encode($iv . $cifrado); */

            $this->IsSMTP();
            $this->Host = 'mail.soluzioni.com.pe';

            // Usa el puerto correcto para SSL
            $this->Port = 465; // Puerto SSL
            $this->SMTPAuth = true;
            $this->SMTPSecure = 'ssl'; // Conexión SSL/TLS desde el inicio

            $this->Username = $this->gCorreo;
            $this->Password = $this->gContrasena;
            $this->setFrom($this->gCorreo,"Nuevo Trámite Registrado en Mesa de Partes Soluzioni Capital");

            $this->CharSet = 'UTF8';
            /* $this->addAddress($usu_correo); */
            $this->addAddress($datos[0]["usu_correo"]);
            $this->addAddress($datos[0]["area_correo"]);
            $this->IsHTML(true);
            $this->Subject = "Mesa de Partes";

            $url = $conexion->ruta();

            $cuerpo = file_get_contents("../assets/email/enviar.html");
            $cuerpo = str_replace("xlinksistema", $url, $cuerpo);

            $cuerpo = str_replace("xnrotramite", $datos[0]["nrotramite"], $cuerpo);
            $cuerpo = str_replace("xarea", $datos[0]["area_nom"], $cuerpo);
            $cuerpo = str_replace("xtramite", $datos[0]["tra_nom"], $cuerpo);
            $cuerpo = str_replace("xnroexterno", $datos[0]["doc_externo"], $cuerpo);
            $cuerpo = str_replace("xtipo", $datos[0]["tip_nom"], $cuerpo);
            $cuerpo = str_replace("xcant", $datos[0]["cant"], $cuerpo);

            $this->Body = $cuerpo;
            $this->AltBody = strip_tags("Enviar Registro");

            try{
                $this->send();
                return true;
            }catch(Exception $e){
                return false;
            }

        }

    }

?>