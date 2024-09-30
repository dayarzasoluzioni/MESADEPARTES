var tabla;
var tabla_detalle;

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

$(document).ready(function() {

    $.post("../../controller/usuario.php?op=comboarea", function(data){

        $('#area_id').html(data);

    });

    $("#area_id").change(function(){

        $("#area_id").each(function(){

            area_id = $(this).val();

            tabla = $("#listado_table").dataTable({

                "aProcessing": true,
                "aServerSide": true,
                dom: 'Bfrtip',
                "searching": true,
                lengthChange: false,
                colReorder: true,
                buttons: [
                  'copyHtml5',
                  'excelHtml5',
                  'csvHtml5',
                  'pdfHtml5'
                ],
                "ajax": {
                  url: '../../controller/documento.php?op=listarxarea',
                  type: "post",
                  data: {area_id: area_id, doc_estado: 'Pendiente'},
                  dataType: "json",
                  error: function(e){
                    console.log(e.responseText);
                  }
                },
                "bDestroy": true,
                "responsive": true,
                "columnDefs": [
                  { "width": "1%", "targets": 0 },
                  { "width": "10%", "targets": 1 },
                  { "width": "10%", "targets": 2 },
                  { "width": "10%", "targets": 3 },
                  { "width": "10%", "targets": 4 },
                  { "width": "10%", "targets": 5 },
                  { "width": "10%", "targets": 6 },
                  { "width": "10%", "targets": 7, "className": "text-center" },
                  { "width": "1%", "targets": 8 },
                ],
                "bInfo": true,
                "iDisplayLength": 10,
                "autowidth": false,
                "language": {
                  "sProcessing": "Procesando...",
                  "sLengthMenu": "Mostrar _MENU_ registros",
                  "sZeroRecords": "No se encontraron resultados",
                  "sEmptyTable": "Ningún dato disponible en esta tabla",
                  "sInfo": "Mostrando un total de _TOTAL_ registros",
                  "sInfoEmpty": "Mostrando un total de 0 registros",
                  "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                  "sInfoPostFix": "",
                  "sSearch": "Buscar:",
                  "sUrl": "",
                  "sInfoThousands": ",",
                  "sLoadingRecords": "Cargando...",
                  "oPaginate": {
                    "sFirst": "Primero",
                    "sLast": "Último",
                    "sNext": "siguiente",
                    "sPrevious": "Anterior"
                  },
                  "oAria": {
                    "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente",
                  }
                }
              }).DataTable();

        });

    });
    
});

function ver(doc_id){

  $.post("../../controller/documento.php?op=mostrar", {doc_id: doc_id}, function(data){

    data = JSON.parse(data);  

    $("#area_nom").val(data.area_nom);
    $("#tra_nom").val(data.tra_nom);
    $("#doc_externo").val(data.doc_externo);    
    $("#tip_nom").val(data.tip_nom);
    $("#doc_dni").val(data.doc_dni);
    $("#doc_nom").val(data.doc_nom);
    $("#doc_descrip").val(data.doc_descrip);

    $("#doc_id").val(data.doc_id);

    if(data.doc_estado == "Pendiente"){

      var resultado = "<span class='badge bg-warning'>Pendiente</span>";

    }else{

      var resultado = "<span class='badge bg-primary'>Terminado</span>";

    }

    $("#lbltramite").html("Nro. Trámite: " + data.nrotramite + " | Usuario: " + data.usu_nomape + " | Correo: " + data.usu_correo + " | Documentos: " + data.cant + " | Estado: " + resultado);

    tabla_detalle = $("#listado_table_detalle").dataTable({

      "aProcessing": true,
      "aServerSide": true,
      /* dom: 'Bfrtip', */
      "searching": false,
      "paging":false,
      lengthChange: false,
      colReorder: true,
      /* buttons: [
        'copyHtml5',
        'excelHtml5',
        'csvHtml5',
        'pdfHtml5'
      ], */
      "ajax": {
        url: '../../controller/documento.php?op=listardetalle',
        type: "post",
        data: {doc_id: doc_id, det_tipo: 'Pendiente'},
        dataType: "json",
        error: function(e){
          console.log(e.responseText);
        }
      },
      "bDestroy": true,
      "responsive": true,
      "columnDefs": [
        { "width": "10%", "targets": 0 },
        { "width": "10%", "targets": 1 },
        { "width": "10%", "targets": 2 },
        { "width": "1%", "targets": 3, "className": "text-center" },
        { "width": "1%", "targets": 4, "className": "text-center" },
      ],
      /* TODO: Para centrar la imagen */
      "createdRow": function(row, data, dataIndex) {
          // Centrar la imagen en la columna 3 (la que tiene la imagen)
          $('td:eq(3)', row).addClass('d-flex justify-content-center align-items-center');
      },
      "bInfo": false,
      "iDisplayLength": 5,
      "autowidth": false,
      "language": {
        "sProcessing": "Procesando...",
        "sLengthMenu": "Mostrar _MENU_ registros",
        "sZeroRecords": "No se encontraron resultados",
        "sEmptyTable": "Ningún dato disponible en esta tabla",
        "sInfo": "Mostrando un total de _TOTAL_ registros",
        "sInfoEmpty": "Mostrando un total de 0 registros",
        "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
        "sInfoPostFix": "",
        "sSearch": "Buscar:",
        "sUrl": "",
        "sInfoThousands": ",",
        "sLoadingRecords": "Cargando...",
        "oPaginate": {
          "sFirst": "Primero",
          "sLast": "Último",
          "sNext": "siguiente",
          "sPrevious": "Anterior"
        },
        "oAria": {
          "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
          "sSortDescending": ": Activar para ordenar la columna de manera descendente",
        }
      }
    }).DataTable();

  });

  $("#mnt_detalle").modal('show');
}

function init(){

  $("#documento_form").on("submit", function(e){

      guardar(e);

  });

}

function guardar (e){

  e.preventDefault();

  if(arrDocument.length === 0){

      Swal.fire({
      title: "No se adjuntaron archivos, desea responder el trámite sin documentos?",
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
      url: "../../controller/documento.php?op=respuesta",
      type: "POST",
      data: formData,
      contentType: false,
      processData: false,
      success: function(data){

          $('#documento_form')[0].reset();
          Dropzone.forElement('.dropzone').removeAllFiles(true);

          $("#mnt_detalle").modal('hide');

          $("#listado_table").DataTable().ajax.reload();

          console.log(data);

          /* data = JSON.parse(data); */
          Swal.fire({
              title: "Mesa de Partes - Respuesta de Trámites",
              html: "Trámite respondido con éxito e informado al usuario <br> Nro. Trámite: <strong>" + data + "</strong>",
              icon: "success",
              confirmButtonColor: "#5156be",
          });
          $('#btnguardar').prop("disabled", false);
          $('#btnguardar').html('Guardar');
      }
  });

}

init();