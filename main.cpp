#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QScreen>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Fusion");

    QScreen *primaryScreen = QGuiApplication::primaryScreen();
    const QRect screenGeometry = primaryScreen ? primaryScreen->geometry() : QRect(0, 0, 800, 480);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("primaryScreenWidth", screenGeometry.width());
    engine.rootContext()->setContextProperty("primaryScreenHeight", screenGeometry.height());

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("svm_display", "Main");

    return app.exec();
}
