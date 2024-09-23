
<div id="mnt_modal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">

        <form method="post" id="mnt_form">

            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="myModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                
                <input type="hidden" id="tra_id" name="tra_id">

                <div class="mb-3">
                    <label for="example-text-input" class="form-label">Nombre Trámite (*)</label>
                    <input class="form-control" type="text" id="tra_nom" name="tra_nom" placeholder="Ingrese el nuevo trámite" required>
                </div>

                <div class="mb-3">
                    <label for="example-text-input" class="form-label">Descripción (*)</label>
                    <textarea class="form-control" type="text" rows="2" value="" id="tra_descrip" name="tra_descrip" placeholder="Ingrese una descripción" required></textarea>
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