var tabla;

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
        {
          extend: 'pdfHtml5',
          orientation: 'landscape',  // Cambiar la orientación a horizontal
          pageSize: 'A4',  // Tamaño del PDF (opcional)
          title: function() {
            // Retorna el título dinámico: Listado de Documentos + Nombre del área seleccionada
            return 'Listado de Trámites Realizados';
          },
          exportOptions: {
              columns: ':visible'  // Exportar solo columnas visibles
          }
        }
      ],
      "ajax": {
        url: '../../controller/documento.php?op=listarusuario',
        type: "get",
        dataType: "json",
        error: function(e){
          console.log(e.responseText);
        }
      },
      "bDestroy": true,
      "responsive": true,
      "columnDefs": [
        { "width": "1%", "targets": 0 },
        { "width": "1%", "targets": 1 },
        { "width": "10%", "targets": 2 },
        { "width": "1%", "targets": 3 },
        { "width": "1%", "targets": 4 },
        { "width": "1%", "targets": 5 },
        { "width": "10%", "targets": 6 },
        { "width": "1%", "targets": 7, "className": "text-center"},
        { "width": "1%", "targets": 8, "className": "text-center" },
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
    $("#doc_respuesta").val(data.doc_respuesta);

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

    tabla_detalle_respuesta = $("#respuesta_table_detalle").dataTable({

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
        data: {doc_id: doc_id, det_tipo: 'Terminado'},
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