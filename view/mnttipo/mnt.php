
<div id="mnt_modal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">

        <form method="post" id="mnt_form">

            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                
                <input type="hidden" id="tip_id" name="tip_id">

                <div class="mb-3">
                    <label for="example-text-input" class="form-label">Nombre Tipo (*)</label>
                    <input class="form-control" type="text" id="tip_nom" name="tip_nom" placeholder="Ingrese el nuevo tipo" required>
                </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary waves-effect waves-light">Guardar</button>
                </div>
            </div>
        
        </form>

    </div>
</div>