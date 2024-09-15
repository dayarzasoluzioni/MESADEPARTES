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