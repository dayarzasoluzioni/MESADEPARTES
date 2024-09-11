$(document).ready(function(){

    

});

$(document).on("click", "#btnrecuperar", function(){

    var usu_correo = $('#usu_correo').val();

    if(usu_correo === ""){

        Swal.fire({
            title: "Recuperar Contraseña",
            text: "El campo correo electrónico no debe estar vacío",
            icon: "error",
            confirmButtonColor: "#5156be",
          });

    }else{

        $.post("../../controller/email.php?op=recuperar", {usu_correo : usu_correo}, function(datos){

            if(datos == 1){
    
                Swal.fire({
                    title: "Recuperar Contraseña",
                    text: "Se ha enviado la nueva contraseña a su correo electrónico",
                    icon: "success",
                    confirmButtonColor: "#5156be",
                  });
    
            }else{
    
                Swal.fire({
                    title: "Recuperar Contraseña",
                    text: "El correo electrónico no se encuentra registrado",
                    icon: "error",
                    confirmButtonColor: "#5156be",
                  });
    
            }
    
        });

    }    

});