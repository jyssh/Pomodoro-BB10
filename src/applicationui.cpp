#include "applicationui.h"
#include "CircularTimer.h"
#include "AppSettings.h"
#include "ActiveFrame.h"

#include <QTimer>
#include <QDir>
#include <QFile>

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/OrientationSupport>
#include <bb/cascades/SupportedDisplayOrientation>
#include <bb/platform/NotificationDefaultApplicationSettings>
#include <bb/platform/NotificationPolicy>


using namespace bb::cascades;


ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
    QObject(app)
{
    qmlRegisterType<QTimer>("pomodoro.lib", 1, 0, "QTimer");
    qmlRegisterType<CircularTimer>("pomodoro.lib", 1, 0, "CircularTimer");

    // By default the QmlDocument object is owned by the Application instance
    // and will have the lifespan of the application
    QmlDocument *qml = QmlDocument::create("asset:///main.qml");

    // Build public assets path, add it as a context property, and expose it to QML
    const QString workingDir = QDir::currentPath();
    const QString dirPaths = QString::fromLatin1("file://%1/app/public/").arg(workingDir);
    qml->documentContext()->setContextProperty("_publicDir", dirPaths);

    qml->setContextProperty("appSettings", new AppSettings(this));

    bb::platform::NotificationDefaultApplicationSettings notificationSettings;
    notificationSettings.setSound(bb::platform::NotificationPolicy::Allow);
    notificationSettings.setLed(bb::platform::NotificationPolicy::Allow);
    notificationSettings.setVibrate(bb::platform::NotificationPolicy::Allow);
    notificationSettings.setVibrateCount(2);
    notificationSettings.apply();

    ActiveFrame *activeFrame = new ActiveFrame();
    Application::instance()->setCover(activeFrame);
    qml->setContextProperty("activeFrame", activeFrame);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);

    OrientationSupport::instance()->setSupportedDisplayOrientation(SupportedDisplayOrientation::CurrentLocked);
}


