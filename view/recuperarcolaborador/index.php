<!doctype html>
<html lang="es">

    <head>

        <meta charset="utf-8">
        <title>Recuperar Contraseña | Soluzioni Capital - Mesa de Partes</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Premium Multipurpose Admin & Dashboard Template" name="description">
        <meta content="Themesbrand" name="author">

        <link rel="icon" href="../../assets/image/soluzionilogo.png" type="image/png">

        <!-- Sweet Alert-->
        <link href="../../assets/css/sweetalert2.min.css" rel="stylesheet" type="text/css">

        <!-- preloader css -->
        <link rel="stylesheet" href="../../assets/css/preloader.min.css" type="text/css">

        <!-- Bootstrap Css -->
        <link href="../../assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css">
        <!-- Icons Css -->
        <link href="../../assets/css/icons.min.css" rel="stylesheet" type="text/css">
        <!-- App Css-->
        <link href="../../assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css">

    </head>

    <body>

    <!-- <body data-layout="horizontal"> -->
        <div class="auth-page">
            <div class="container-fluid p-0">
                <div class="row g-0">
                    <div class="col-xxl-3 col-lg-4 col-md-5">
                        <div class="auth-full-page-content d-flex p-sm-5 p-4">
                            <div class="w-100">
                                <div class="d-flex flex-column h-100">
                                    <div class="mb-4 mb-md-5 text-center">
                                        <a href="index-1.html" class="d-block auth-logo">
                                            <img src="../../assets/image/soluzionilogo.png" alt="" height="28"> <span class="logo-txt">Soluzioni Capital</span>
                                        </a>
                                    </div>
                                    <div class="auth-content my-auto">
                                        <div class="text-center">
                                            <h5 class="mb-0">Recuperar Contraseña - Colaborador</h5>
                                            <p class="text-muted mt-2">Recuperar Contraseña Mesa de Partes - Colaborador</p>
                                        </div>
                                        <div class="alert alert-success text-center mb-4 mt-4 pt-2" role="alert">
                                            Ingrese su correo electrónico y siga las instrucciones
                                        </div>
                                        <form class="custom-form mt-4">
                                            <div class="mb-3">
                                                <label class="form-label">Correo Electrónico del Colaborador</label>
                                                <input type="email" class="form-control" id="usu_correo" name="usu_correo" placeholder="Ingrese Correo Electrónico">
                                            </div>
                                            <div class="mb-3 mt-4">
                                                <a class="btn btn-primary w-100 waves-effect waves-light" id="btnrecuperar" style="background-color: #d63838">Recuperar</a>
                                            </div>
                                        </form>

                                        <div class="mt-5 text-center">
                                            <p class="text-muted mb-0"> ¿Recordaste tu contraseña?  <a href="../../view/accesopersonal/index.php" class="text-primary fw-semibold"> Acceder </a> </p>
                                        </div>
                                    </div>
                                    <!-- <div class="mt-4 mt-md-5 text-center">
                                        <p class="mb-0">© <script>document.write(new Date().getFullYear())</script> Soluzioni Capital <i class="mdi mdi-heart text-danger"></i> Todos los derechos reservados</p>
                                    </div> -->
                                    <div class="mt-4 mt-md-5 text-center">
                                        <p class="mb-0">© <span id="currentYear"></span> Soluzioni Capital <i class="mdi mdi-heart text-danger"></i> Todos los derechos reservados</p>
                                    </div>

                                    <script>
                                        // Inserta el año actual en el elemento con id "currentYear"
                                        document.getElementById('currentYear').textContent = new Date().getFullYear();
                                    </script>

                                </div>
                            </div>
                        </div>
                        <!-- end auth full page content -->
                    </div>
                    <!-- end col -->
                    <?php require_once("../html/carrusel.php")?>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- end container fluid -->
        </div>


        <!-- JAVASCRIPT -->
        <script src="../../assets/js/jquery.min.js"></script>
        <script src="../../assets/js/bootstrap.bundle.min.js"></script>
        <script src="../../assets/js/metisMenu.min.js"></script>
        <script src="../../assets/js/simplebar.min.js"></script>
        <script src="../../assets/js/waves.min.js"></script>
        <script src="../../assets/js/feather.min.js"></script>
        <!-- pace js -->
        <script src="../../assets/js/pace.min.js"></script>

        <!-- Sweet Alerts js -->
        <script src="../../assets/js/sweetalert2.min.js"></script>

        <script type="text/javascript" src="recuperarcolaborador.js"></script>

    </body>

</html>