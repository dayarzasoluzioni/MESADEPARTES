let arrImages = [];

Dropzone.autoDiscover = false;

/* TODO: Validaciones a los documentos a cargar en el dropzone */
let myDropzone = new Dropzone('.dropzone',{

    url: '../../assets/document',
    maxFilesize: 2,
    maxFiles: 5,
    acceptedFiles: 'application/pdf',
    addRemoveLinks: true,
    dictRemoveFile: 'Eliminar',

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

function init(){

    $("#documento_form").on("submit", function(e){

        guardar(e);

    });

}

function guardar (e){

    e.preventDefault();
    var formData = new FormData($("#documento_form")[0]);
    $.ajax({

        url: "../../controller/documento.php?op=registrar",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function(data){
            console.log(data);
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

init();