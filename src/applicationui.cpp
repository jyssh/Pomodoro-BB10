#include "applicationui.h"
#include "CircularTimer.h"
#include "AppSettings.h"
#include "ActiveFrame.h"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/OrientationSupport>
#include <bb/cascades/SupportedDisplayOrientation>

using namespace bb::cascades;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
    QObject(app)
{
    qmlRegisterType<CircularTimer>("pomodoro.lib", 1, 0, "CircularTimer");

    // By default the QmlDocument object is owned by the Application instance
    // and will have the lifespan of the application
    QmlDocument *qml = QmlDocument::create("asset:///main.qml");

    qml->setContextProperty("appSettings", new AppSettings(this));

    ActiveFrame *activeFrame = new ActiveFrame();
    Application::instance()->setCover(activeFrame);
    qml->setContextProperty("activeFrame", activeFrame);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);

    OrientationSupport::instance()->setSupportedDisplayOrientation(SupportedDisplayOrientation::CurrentLocked);
}


