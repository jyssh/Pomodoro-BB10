/*
 * ActiveFrame.cpp
 *
 *  Created on: Feb 22, 2015
 *      Author: ghost
 */

#include "ActiveFrame.h"

#include <bb/cascades/Container>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

ActiveFrame::ActiveFrame(QObject *parent) :
        SceneCover(parent)
{
    QmlDocument *qml = QmlDocument::create("asset:///ActiveFrame.qml").parent(parent);
    Container *mainContainer = qml->createRootObject<Container>();
    setContent(mainContainer);

    mTimerType = mainContainer->findChild<Label*>("TimerType");
    mTimerType->setParent(mainContainer);

    mTimeLeft = mainContainer->findChild<Label*>("TimeLeft");
    mTimeLeft->setParent(mainContainer);
}

ActiveFrame::~ActiveFrame()
{
    // TODO Auto-generated destructor stub
}

void ActiveFrame::update(QString timerType, QString timeLeft)
{
    mTimerType->setText(timerType);
    mTimeLeft->setText(timeLeft);
}
