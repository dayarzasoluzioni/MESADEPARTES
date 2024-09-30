<?php

    require_once("../../config/conexion.php");
    require_once("../../models/Rol.php");
    $rol = new Rol();
    $datos = $rol->validar_menu_x_rol($_SESSION["rol_id"], "nuevotramite");

    if(isset($_SESSION["usu_id"]) and count($datos) > 0){

    
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
                                            <form method="post" id="documento_form">
                                                <div class="row">                                                

                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">Área (*)</label>
                                                            <select class="form-select" name="area_id" id="area_id" placeholder="Seleccione el área" required>
                                                                <option value="" disabled selected>Seleccionar</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="example-text-input" class="form-label">Trámite (*)</label>
                                                            <select class="form-select" name="tra_id" id="tra_id" placeholder="Seleccione el trámite" required>
                                                                <option value="" disabled selected>Seleccionar</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="example-text-input" class="form-label">Nro. Externo</label>
                                                            <input class="form-control" type="text" value="" id="doc_externo" name="doc_externo" placeholder="Ingrese el número externo">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="form-label" class="form-label">Tipo (*)</label>
                                                            <select class="form-select" name="tip_id" id="tip_id" placeholder="Seleccione el tipo" required>
                                                                <option value="" disabled selected>Seleccionar</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-3">
                                                        <div class="mb-3">
                                                            <label for="example-text-input" class="form-label">DNI / RUC (*)</label>
                                                            <input class="form-control" type="number" value="" id="doc_dni" name="doc_dni" placeholder="Ingrese el número de documento" min="0" required>
                                                            <small id="dniError" style="color: red; display: none;">El número de documento debe tener al menos 8 dígitos.</small>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="mb-3">
                                                            <label for="example-text-input" class="form-label">Nombre / Razón Social (*)</label>
                                                            <input class="form-control" type="number" value="" id="doc_dni" name="doc_dni" placeholder="Ingrese el número de documento" min="0" required>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg12">
                                                        <div class="mb-3">
                                                            <label for="example-text-input" class="form-label">Descripción (*)</label>
                                                            <textarea class="form-control" type="text" rows="2" value="" id="doc_descrip" name="doc_descrip" placeholder="Ingrese una descripción" required></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-12">
                                                        <!-- <form action="#" class="dropzone"> -->
                                                            <!-- <div class="fallback">
                                                                <input name="file" type="file" multiple="multiple">
                                                            </div>
                                                            <div class="dz-message needsclick">
                                                                <div class="mb-3">
                                                                    <i class="display-4 text-muted bx bx-cloud-upload"></i>
                                                                </div>
                
                                                                <h5>Suelte los archivos aqui o de clic para cargarlos.</h5>
                                                            </div> -->
                                                        <!-- </form> -->

                                                        <div class="dropzone">

                                                            <div class="dz-default dz-message">

                                                                <button class="dz-button" type="button">

                                                                    <img src="../../assets/image/upload.png" alt="">

                                                                </button>

                                                                <div class="dz-message" data-dz-message>

                                                                    <h5>
                                                                        
                                                                        Suelte los archivos aqui o de clic para cargarlos.
                                                                        <br><br>
                                                                        Máximo 5 archivos de tipo *.PDF, *.XML, Excel, Word y máximo 5MB cada uno.

                                                                    </h5>

                                                                </div>

                                                            </div>

                                                        </div>

                                                    </div>
                                                    
                                                    <div class="d-flex flex-wrap gap-2 mt-4 text-center">
                                                        <button type="button" id="btnlimpiar" class="btn btn-secondary waves-effect waves-light">Limpiar</button>
                                                        <button type="submit" id="btnguardar" class="btn btn-primary waves-effect waves-light">Guardar</button>
                                                    </div>                                                
                                            
                                                </div>
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

        <script>
            document.getElementById('doc_dni').addEventListener('input', function() {
                let dni = this.value;
                let dniError = document.getElementById('dniError');

                // Remueve los ceros a la izquierda
                let dniSinCeros = dni.replace(/^0+/, '');

                if (dniSinCeros.length < 8 && dni.length > 0) {
                    dniError.style.display = 'block'; // Muestra el mensaje de error
                } else {
                    dniError.style.display = 'none'; // Oculta el mensaje de error
                }
            });
        </script>

        <script type="text/javascript" src="nuevotramite.js"></script>

    </body>
</html>

<?php

    }else{
        header("Location:".Conectar::ruta()."index.php");
    }

?>
