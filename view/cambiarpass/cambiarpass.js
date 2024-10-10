$(document).ready(function(){
    $('#cambiarPassForm').on('submit', function(event){
        event.preventDefault(); //TODO: Evita que el formulario se envíe por defecto

        //TODO: Captura las contraseñas ingresadas
        let password = $('#new_password').val();
        let confirmPassword = $('#confirm_password').val();
        let userId = $('#usu_id').val();

        //TODO: Verifica si las contraseñas son iguales
        if(password === confirmPassword) {

            //TODO: Mostrar los datos para verificar que están correctos
            console.log("Datos a enviar:", { usu_id: userId, usu_pass: password });

            //TODO: Si coinciden, realiza la petición AJAX al controlador
            $.ajax({
                url: "../../controller/usuario.php?op=cambiarpass", //TODO: Ruta de tu controlador
                method: "POST",
                data: {
                    usu_id: userId, //TODO: Id del usuario
                    usu_pass: password //TODO: La nueva contraseña
                },
                success: function(response){
                    console.log("Respuesta del servidor:", response);
                    /* if(response === "1"){
                        alert("Contraseña actualizada exitosamente");
                    } else {
                        alert("Contraseña Actualizada correctamente.");
                    } */
                    Swal.fire({
                        title: "Mesa de Partes - Contraseña",
                        text: "Contraseña actualizada correctamente",
                        icon: "success",
                        confirmButtonColor: "#5156be",
                    }).then(() => {
                        //TODO: Limpia los campos de contraseña después de cerrar el mensaje
                        $('#new_password').val(''); //TODO: Limpia el campo de nueva contraseña
                        $('#confirm_password').val(''); //TODO: Limpia el campo de confirmar contraseña
                    });
                },
                error: function(){
                    alert("Error en la solicitud.");
                }
            });

        } else {
            //TODO: Si no coinciden, muestra un mensaje de error
            Swal.fire({
                title: "Mesa de Partes - Contraseña",
                text: "Las contraseñas no coinciden",
                icon: "error",
                confirmButtonColor: "#5156be",
              });
        }
    });
});
