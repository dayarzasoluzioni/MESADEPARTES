<?php
    require_once("../../config/conexion.php");
    if(isset($_SESSION["usu_id"])){

    
?>
<!doctype html>
<html lang="es">

    <head>
        
        <title>Gestionar Trámite - Colaborador | Soluzioni Capital - Mesa de Partes</title>
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
                                    <h4 class="mb-sm-0 font-size-18">Gestionar Trámite</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <!-- <li class="breadcrumb-item"><a href="javascript: void(0);">Pages</a></li> -->
                                            <li class="breadcrumb-item active">Inicio</li>
                                        </ol>
                                    </div>

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
