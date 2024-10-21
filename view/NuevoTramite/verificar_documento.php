<?php
if (isset($_POST['documento']) && isset($_POST['tipo'])) {
    $documento = $_POST['documento'];
    $tipo = $_POST['tipo'];

    //TODO: Determinar la URL de la API según el tipo de documento
    if ($tipo == 'dni') {
        $apiUrl = "https://api.apis.net.pe/v2/reniec/dni?numero=" . $documento;
    } else if ($tipo == 'ruc') {
        $apiUrl = "https://api.apis.net.pe/v2/sunat/ruc?numero=" . $documento;
    } else {
        echo json_encode(['success' => false, 'message' => 'Tipo de documento no válido.']);
        exit;
    }

    //TODO: Utiliza tu token para autenticar la solicitud
    $apiKey = "apis-token-11058.b9fpe8wVXePX4bD3gfj5DDjAaJYauJx8";

    //TODO: Llamada a la API
    $response = verificarApi($apiUrl, $apiKey, $tipo);

    //TODO: Procesar la respuesta de la API
    $data = json_decode($response, true);

    if ($tipo == 'dni' && isset($data['nombres']) && isset($data['apellidoPaterno']) && isset($data['apellidoMaterno'])) {
        //TODO: Concatenar nombres y apellidos
        $nombreCompleto = $data['nombres'] . ' ' . $data['apellidoPaterno'] . ' ' . $data['apellidoMaterno'];
        echo json_encode(['success' => true, 'nombre_completo' => $nombreCompleto]);
    } else if ($tipo == 'ruc' && isset($data['razonSocial'])) {
        //TODO: En el caso de RUC, se toma el nombre (razón social)
        echo json_encode(['success' => true, 'nombre_completo' => $data['razonSocial']]);
    } else {
        //TODO: Mostrar la respuesta cruda de la API para analizarla
        echo json_encode([
            'success' => false, 
            'message' => 'No se encontró información o hubo un error en la API.',
            'response' => $response //TODO: Mostrar la respuesta de la API
        ]);
    }
}

function verificarApi($url, $apiKey, $tipo) {
    $curl = curl_init();

    //TODO: Configurar encabezados comunes
    $headers = [
        "Authorization: Bearer $apiKey"
    ];

    //TODO: Agregar 'Referer' solo si es un RUC
    if ($tipo == 'ruc') {
        $headers[] = "Referer: http://apis.net.pe/api-ruc";
    }

    curl_setopt_array($curl, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => $headers
    ]);

    $response = curl_exec($curl);

    //TODO: Manejo de errores en la solicitud HTTP
    if ($response === false) {
        $error = curl_error($curl);
        curl_close($curl);
        return json_encode(['success' => false, 'message' => 'Error en la solicitud: ' . $error]);
    }

    curl_close($curl);
    return $response;
}
?>
