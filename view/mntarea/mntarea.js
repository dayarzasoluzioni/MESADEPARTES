var tabla;

function init(){

    $("#mnt_form").on("submit", function(e){

        guardaryeditar(e);        

    });

}

function guardaryeditar (e){

    e.preventDefault();

    /* $('#btnguardar').prop("disabled", true);
        $('#btnguardar').html('<i class="bx bx-hourglass bx-spin font-size-16 align-middle me-2"></i>Espere...'); */

    var formData = new FormData($("#mnt_form")[0]);
    
    $.ajax({
        url: "../../controller/area.php?op=guardaryeditar",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function(datos){

          console.log(datos);

          if(datos == 1){              

            $("#area_id").val('');

            $("#listado_table").DataTable().ajax.reload();
  
            $("#mnt_modal").modal('hide');
  
            $('#mnt_form')[0].reset();

            Swal.fire({
              title: "Mantenimiento area",
              text: "Nuevo area Registrado",
              icon: "success",
              confirmButtonColor: "#5156be",
            });

          }else if(datos == 0){

            Swal.fire({
              title: "Mantenimiento area",
              text: "El area ya se encuentra registrado",
              icon: "error",
              confirmButtonColor: "#5156be",
            });

            /* $('#mnt_form')[0].reset(); */

          }else if(datos == 2){
            $("#area_id").val('');

            $('#mnt_form')[0].reset();

            $("#listado_table").DataTable().ajax.reload();
  
            $("#mnt_modal").modal('hide');           

            Swal.fire({
              title: "Mantenimiento area",
              text: "Registro Editado",
              icon: "success",
              confirmButtonColor: "#5156be",
            });
          }

        }
    });

}

$(document).ready(function () {
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
        url: '../../controller/area.php?op=listar',
        type: "get",
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

$(document).on("click", "#btnnuevo", function(){

  $("#area_id").val('');
  $("#mnt_form")[0].reset();
  $("#mnt_modal").modal('show');
  $("#myModalLabel").html('Nueva area');

});

function editar(area_id){

  $("#myModalLabel").html('Editar area');

  $.post("../../controller/area.php?op=mostrar", {area_id: area_id}, function(data){

    data = JSON.parse(data);
    $("#area_id").val(data.area_id);
    $("#area_nom").val(data.area_nom);
    $("#area_correo").val(data.area_correo);
    $("#mnt_modal").modal('show');

  });

}

function eliminar(area_id){

  Swal.fire({
    title: "¿Está seguro de eliminar el registro?",
    icon: "question",
    showDenyButton: true,
    confirmButtonText: "Si",
    denyButtonText: `No`
    }).then((result) => {
    /* Read more about isConfirmed, isDenied below */
    if (result.isConfirmed) {

      $.post("../../controller/area.php?op=eliminar", {area_id: area_id}, function(data){

        $("#listado_table").DataTable().ajax.reload();

        Swal.fire({
          title: "Mantenimiento area",
          text: "Registro Eliminado",
          icon: "success",
          confirmButtonColor: "#5156be",
        });
    
      });

    } 
    });

}

init();