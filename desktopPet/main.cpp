#include <QGuiApplication>
#include <QDebug>
#include <QFont>
#include <QFontDatabase>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    const int fontId = QFontDatabase::addApplicationFont(
        QStringLiteral(":/qt/qml/desktopPet/assets/fonts/NotoSansJP-Variable.ttf"));
    if (fontId < 0) {
        qCritical() << "Failed to load the bundled Noto Sans JP font.";
        return 1;
    }

    const QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    if (fontFamilies.isEmpty()) {
        qCritical() << "The bundled Noto Sans JP font has no registered family.";
        return 1;
    }

    QGuiApplication::setFont(QFont(fontFamilies.constFirst()));

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("desktopPet", "MainWindow");

    return QGuiApplication::exec();
}
