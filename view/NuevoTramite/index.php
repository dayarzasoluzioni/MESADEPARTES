<?php
    require_once("../../config/conexion.php");
    if(isset($_SESSION["usu_id"])){

    
?>
<!doctype html>
<html lang="es">

    <head>
        
        <title>Nuevo Trámite | Soluzioni Capital - Mesa de Partes</title>
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
                                    <h4 class="mb-sm-0 font-size-18">Nuevo Trámite</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="../home/">Inicio</a></li>
                                            <li class="breadcrumb-item active">Nuevo Trámite</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h4 class="card-title">Ingrese toda la información requerida.</h4>
                                            <p class="card-title-desc">(*) Datos obligatorios. </p>
                                        </div>

                                        <div class="card-body">
                                            <div class="row">

                                            <div class="col-lg-3">
                                                <div class="mb-3">
                                                    <label for="form-label" class="form-label">Área (*)</label>
                                                    <select class="form-select" name="area_id" id="area_id" placeholder="Seleccione el área">
                                                        <option value="" disabled selected>Seleccionar</option>
                                                        <option value="Choice 1">Choice 1</option>
                                                        <option value="Choice 2">Choice 2</option>
                                                        <option value="Choice 3">Choice 3</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-lg-9">
                                                <div class="mb-3">
                                                    <label for="example-text-input" class="form-label">Trámite (*)</label>
                                                    <select class="form-select" name="tra_id" id="tra_id" placeholder="Seleccione el trámite">
                                                        <option value="" disabled selected>Seleccionar</option>
                                                        <option value="Choice 1">Choice 1</option>
                                                        <option value="Choice 2">Choice 2</option>
                                                        <option value="Choice 3">Choice 3</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-lg-3">
                                                <div class="mb-3">
                                                    <label for="form-label" class="form-label">Tipo (*)</label>
                                                    <select class="form-select" name="tip_id" id="tip_id" placeholder="Seleccione el tipo">
                                                        <option value="" disabled selected>Seleccionar</option>
                                                        <option value="Choice 1">Natural</option>
                                                        <option value="Choice 2">Jurídica</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-lg-3">
                                                <div class="mb-3">
                                                    <label for="example-text-input" class="form-label">DNI / RUC (*)</label>
                                                    <input class="form-control" type="number" value="" id="example-text-input" placeholder="Ingrese el número de documento">
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label for="example-text-input" class="form-label">Nombre / Razón Social (*)</label>
                                                    <input class="form-control" type="text" value="" id="example-text-input" placeholder="Ingrese el nombre o razón social">
                                                </div>
                                            </div>

                                            <div class="col-lg12">
                                                <div class="mb-3">
                                                    <label for="example-text-input" class="form-label">Descripción (*)</label>
                                                    <textarea class="form-control" type="text" rows="2" value="" id="example-text-input" placeholder="Ingrese una descripción"></textarea>
                                                </div>
                                            </div>

                                            <div class="col-lg-12">
                                                <form action="#" class="dropzone">
                                                    <div class="fallback">
                                                        <input name="file" type="file" multiple="multiple">
                                                    </div>
                                                    <div class="dz-message needsclick">
                                                        <div class="mb-3">
                                                            <i class="display-4 text-muted bx bx-cloud-upload"></i>
                                                        </div>
        
                                                        <h5>Drop files here or click to upload.</h5>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="d-flex flex-wrap gap-2 mt-4 text-center">
                                                <button type="button" class="btn btn-secondary waves-effect waves-light">Limpiar</button>
                                                <button type="button" class="btn btn-primary waves-effect waves-light">Guardar</button>
                                            </div>
                                            
                                            </div>
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

        <script type="text/javascript" src="nuevotramite.js"></script>

    </body>
</html>

<?php

    }else{
        header("Location:".Conectar::ruta()."index.php");
    }

?>
