# Actividades de una Cooperativa Pesquera — Qt for Mobile

Aplicación de ejemplo para organizar actividades de una cooperativa pesquera con Qt Quick y QML. Está pensada para ejecutarse como aplicación móvil Android desde Qt Creator; no busca administrar todos los procesos de una cooperativa.

## Funciones

- Ver una lista dinámica de actividades de la cooperativa.
- Crear y editar actividades desde un formulario.
- Validar el nombre y la descripción antes de guardar.
- Asignar cada actividad a un área: pesca, mantenimiento, comercialización o administración.
- Marcar una actividad como hecha o pendiente y eliminarla.
- Navegar entre la lista y el formulario con `StackView`.

## Requisitos

- Qt 6.8 con el kit Android instalado.
- Qt Creator.
- Android SDK, NDK y JDK configurados en **Preferences > SDKs > Android**.
- Un emulador Android configurado en Android Studio para la demostración en PC.

La aplicación guarda los datos en un `ListModel` local en memoria. Las actividades de ejemplo y los cambios se pierden al cerrar la aplicación.

## Abrir y ejecutar

1. En Qt Creator, selecciona **File > Open File or Project...**.
2. Abre `CMakeLists.txt` de esta carpeta.
3. Selecciona el kit **Qt 6.8.3 for Android** y configura el emulador como dispositivo de ejecución.
4. Pulsa **Run**. Si tienes un kit de escritorio de Qt 6.8.3, también puedes seleccionarlo para una primera ejecución en Windows.