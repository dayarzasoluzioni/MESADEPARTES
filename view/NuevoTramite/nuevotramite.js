let arrDocument = [];

Dropzone.autoDiscover = false;

/* TODO: Validaciones a los documentos a cargar en el dropzone */
let myDropzone = new Dropzone('.dropzone', {

    /* url: '../../assets/document', */
    url: '../../controller/documento.php?op=temporary_upload',
    maxFilesize: 5, // Tamaño máximo de archivo en MB
    maxFiles: 5, // Número máximo de archivos
    acceptedFiles: 'application/pdf, text/xml, application/xml, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    addRemoveLinks: true,
    dictRemoveFile: 'Eliminar',
    cache: false,
    processData: false,
    error: function(file, response) {
        console.log('Error durante la carga del archivo');
    }

});


myDropzone.on('maxfilesexceeded', function(file){

    Swal.fire({
        title: "Mesa de Partes - Carga de Documentos",
        text: "Solo se permite un máximo de 5 archivos",
        icon: "error",
        confirmButtonColor: "#5156be",
      });
    myDropzone.removeFile(file);

});

myDropzone.on('addedfile', function(file){

    if(file.size > 5 * 1024 * 1024){

        Swal.fire({
            title: "Mesa de Partes - Tamaño máximo del Documento",
            text: 'El archivo "' + file.name + '" excede el tamaño máximo de 5MB',
            icon: "error",
            confirmButtonColor: "#5156be",
          });
        myDropzone.removeFile(file);

    }

});

myDropzone.on('addedfile', file =>{

    arrDocument.push(file);

});

myDropzone.on('removedfile', file =>{

    let i = arrDocument.indexOf(file);
    arrDocument.splice(i, 1);

});

function init(){

    $("#documento_form").on("submit", function(e){

        guardar(e);

    });

}

function guardar (e){

    e.preventDefault();

    if(arrDocument.length === 0){

        Swal.fire({
        title: "No se adjuntaron archivos, desea registrar el trámite sin documentos?",
        icon: "info",
        showDenyButton: true,
        confirmButtonText: "Si",
        denyButtonText: `No`
        }).then((result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {

            enviartramite();

        } 
        });
    }else{

        enviartramite();

    }

}

function enviartramite(){

    $('#btnguardar').prop("disabled", true);
    $('#btnguardar').html('<i class="bx bx-hourglass bx-spin font-size-16 align-middle me-2"></i>Espere...');
    var formData = new FormData($("#documento_form")[0]);
    var totalfiles = arrDocument.length;
      
    for(var i = 0; i < totalfiles; i++){
        formData.append("file[]", arrDocument[i]);
    }
    $.ajax({
        url: "../../controller/documento.php?op=registrar",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function(data){
            $('#documento_form')[0].reset();
            Dropzone.forElement('.dropzone').removeAllFiles(true);
            console.log(data);
            /* data = JSON.parse(data); */
            Swal.fire({
                title: "Mesa de Partes - Registro de Trámites",
                html: "Trámite registrado con éxito y número: <br><strong>" + data + "</strong>",
                icon: "success",
                confirmButtonColor: "#5156be",
            });
            $('#btnguardar').prop("disabled", false);
            $('#btnguardar').html('Guardar');
        }
    });

}

$(document).ready(function() {

    $.post("../../controller/area.php?op=combo", function(data){

        $('#area_id').html(data);

    });

    $.post("../../controller/tramite.php?op=combo", function(data){

        $('#tra_id').html(data);

    });

    $.post("../../controller/tipo.php?op=combo", function(data){

        $('#tip_id').html(data);

    });
    
});

$(document).on("click","#btnlimpiar", function(){

    $('#documento_form')[0].reset();
    Dropzone.forElement('.dropzone').removeAllFiles(true);

});

init();