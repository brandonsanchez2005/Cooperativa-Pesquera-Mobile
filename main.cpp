#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCoreApplication>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(EXIT_FAILURE); },
        Qt::QueuedConnection);

    engine.loadFromModule("CooperativaPesquera", "Main");

    return app.exec();
}
