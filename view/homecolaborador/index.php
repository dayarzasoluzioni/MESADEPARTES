<?php
    require_once("../../config/conexion.php");
    require_once("../../models/Rol.php");
    $rol = new Rol();
    $datos = $rol->validar_menu_x_rol($_SESSION["rol_id"], "homecolaborador");

    if(isset($_SESSION["usu_id"]) and count($datos) > 0){

    
?>
<!doctype html>
<html lang="es">

    <head>
        
        <title>Página de Inicio - Colaborador | Soluzioni Capital - Mesa de Partes</title>
        <?php require_once("../html/head.php") ?>
        
    </head>

    <body>

        <div id="layout-wrapper">
            
        <?php require_once("../html/header.php") ?>

            <?php require_once("../html/menu.php") ?>

            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Inicio - Colaborador</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <!-- <li class="breadcrumb-item"><a href="javascript: void(0);">Pages</a></li> -->
                                            <li class="breadcrumb-item active">Inicio</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>

                            <div class="card border border-primary">
                                <div class="card-header bg-transparent border-primary">
                                    <h5 class="my-0 text-primary"><i class="mdi mdi-bullseye-arrow me-3"></i>Instrucciones para responder un registro de la Mesa de Partes</h5>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">Leer Atentamente: </h5>
                                    <br>
                                    <h6 class="card-title">Paso 1: </h6>
                                    <p class="card-text">
                                        - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                                    </p>
                                    <h6 class="card-title">Paso 2: </h6>
                                    <p class="card-text">
                                        - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                                    </p>
                                    <h6 class="card-title">Paso 3: </h6>
                                    <p class="card-text">
                                        - It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
                                    </p>
                                </div>
                            </div>

                            <div class="card border border-primary">
                                <div class="card-header bg-transparent border-primary">
                                    <h5 class="my-0 text-primary"><i class="mdi mdi-bullseye-arrow me-3"></i>Términos y Condiciones</h5>
                                </div>
                                <div class="card-body">

                                    <h5 class="card-title">Tener en cuenta: </h5>
                                    <br>
                                    <!-- <h6 class="card-title">1: </h6> -->
                                    <p class="card-text">
                                        - Solo se cuenta con 72 horas para responder un trámite asignado a su área.
                                    </p>
                                    <p class="card-text">
                                        - El flujo termina cuando se envía una respuesta al usuario.
                                    </p>
                                    
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>

                <?php require_once("../html/footer.php") ?>

            </div>


        </div>

        <?php require_once("../html/sidebar.php") ?>

        <div class="rightbar-overlay"></div>

        <?php require_once("../html/js.php") ?>

    </body>
</html>

<?php

    }else{
        header("Location:".Conectar::ruta()."index.php");
    }

?>
