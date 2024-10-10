<?php
    require_once("../../config/conexion.php");
    require_once("../../models/Usuario.php");
    /* $rol = new Rol();
    $datos = $rol->validar_menu_x_rol($_SESSION["rol_id"], "mntarea");

    if(isset($_SESSION["usu_id"]) and count($datos) > 0){ */

    
?>
<!doctype html>
<html lang="es">

    <head>
        
        <title>Cambio de Contraseña | Soluzioni Capital - Mesa de Partes</title>
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
                                    <h4 class="mb-sm-0 font-size-18">Perfil</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <!-- <li class="breadcrumb-item"><a href="javascript: void(0);">Pages</a></li> -->
                                            <!-- <li class="breadcrumb-item active">Inicio</li> -->
                                        </ol>
                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h4 class="card-title">Cambio de contraseña</h4>
                                            <p class="card-title-desc">Vista para modificar su contraseña. </p>
                                        </div>

                                        <input type="hidden" id="usu_id" value="<?php echo $_SESSION["usu_id"]?>">

                                        <div class="card-body">

                                        <form id="cambiarPassForm">

                                            <div class="row">

                                                <div class="col-lg-6">
                                                    <div class="mb-3">
                                                        <label for="example-text-input" class="form-label">Nueva Contraseña: </label>
                                                        <input class="form-control" type="password" value="" id="new_password" name="new_password" placeholder="Ingrese la nueva contraseña">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="mb-3">
                                                        <label for="example-text-input" class="form-label">Confirme Nueva Contraseña: </label>
                                                        <input class="form-control" type="password" value="" id="confirm_password" name="confirm_password" placeholder="Confirme la nueva contraseña">
                                                    </div>
                                                </div>

                                            </div>
                                            

                                            <button type="submit" id="btncambiarpass" class="btn btn-primary waves-effect waves-light">Cambiar</button>

                                        </form>
                                            

                                        </div>
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

        <script type="text/javascript" src="cambiarpass.js"></script>

    </body>
</html>

<?php

    /* }else{
        header("Location:".Conectar::ruta()."index.php");
    } */

?>
