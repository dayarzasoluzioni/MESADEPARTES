<div class="vertical-menu">
    <div data-simplebar="" class="h-100">

        <div id="sidebar-menu">

            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title" data-key="t-menu">Menú</li>

                <?php

                    if($_SESSION["rol_id"] == 1){

                        ?>

                            <li>
                                <a href="../home/">
                                    <i data-feather="home"></i>
                                    <span data-key="t-dashboard">Inicio</span>
                                </a>
                            </li>

                            <li>
                                <a href="../NuevoTramite/">
                                    <i data-feather="grid"></i>
                                    <span data-key="t-apps">Nuevo Trámite</span>
                                </a>
                            </li>

                            <li>

                                <a href="../ConsultarTramite/">
                                    <i data-feather="users"></i>
                                    <span data-key="t-authentication">Consultar Trámite</span>
                                </a>

                            </li>

                        <?php

                    }elseif($_SESSION["rol_id"] == 2){

                        ?>

                            <li>
                                <a href="../homecolaborador/">
                                    <i data-feather="home"></i>
                                    <span data-key="t-dashboard">Inicio Colaborador</span>
                                </a>
                            </li>

                            <li>
                                <a href="../gestionartramite/">
                                    <i data-feather="briefcase"></i>
                                    <span data-key="t-apps">Gestionar Trámite</span>
                                </a>
                            </li>

                            <li>

                                <a href="../buscartramite/">
                                    <i data-feather="search"></i>
                                    <span data-key="t-authentication">Buscar Trámite</span>
                                </a>

                            </li>

                        <?php

                    }elseif($_SESSION["rol_id"] == 3){

                        ?>

                            <li>
                                <a href="../mntusuario/">
                                    <i class="fas fa-users"></i>
                                    <span data-key="t-dashboard">Mnt. Colaborador</span>
                                </a>
                            </li>

                            <li>
                                <a href="../mntarea/">
                                    <i class="fas fa-network-wired"></i>
                                    <span data-key="t-apps">Mnt. Área</span>
                                </a>
                            </li>

                            <li>

                                <a href="../mnttramite/">
                                    <i class=" bx bx-file"></i>
                                    <span data-key="t-authentication">Mnt. Trámite</span>
                                </a>

                            </li>

                            <li>

                                <a href="../mnttipo/">
                                    <i class="fas fa-user-cog"></i>
                                    <span data-key="t-authentication">Mnt. Tipo</span>
                                </a>

                            </li>

                        <?php

                    }

                ?>
            
            </ul>

        </div>
    </div>

</div>