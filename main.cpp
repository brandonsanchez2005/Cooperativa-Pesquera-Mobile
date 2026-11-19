#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCoreApplication>
#include <QQuickWindow>
#include <QSGRendererInterface>

int main(int argc, char *argv[])
{
    // Usa Vulkan para dibujar la interfaz (con OpenGL se veían rayas, este fue el cambio de correción al final)
    QQuickWindow::setGraphicsApi(QSGRendererInterface::Vulkan);

    // Objeto principal de la aplicación gráfica
    QGuiApplication app(argc, argv);

    // Motor que carga y ejecuta los archivos QML
    QQmlApplicationEngine engine;
    
    // Si el QML no se puede cargar, cierra la app con error
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(EXIT_FAILURE); },
        Qt::QueuedConnection);

    // Carga Main.qml del módulo definido en CMakeLists.txt
    engine.loadFromModule("CooperativaPesquera", "Main");

    // Inicia el ciclo de eventos y mantiene la app abierta
    return app.exec();
}