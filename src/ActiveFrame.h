/*
 * ActiveFrame.h
 *
 *  Created on: Feb 22, 2015
 *      Author: ghost
 */

#ifndef ACTIVEFRAME_H_
#define ACTIVEFRAME_H_

#include <QObject>
#include <bb/cascades/SceneCover>
#include <bb/cascades/Label>

using namespace bb::cascades;

class ActiveFrame: public SceneCover
{
    Q_OBJECT

public:
    ActiveFrame(QObject *parent = 0);
    virtual ~ActiveFrame();

public slots:
    Q_INVOKABLE void update(QString timerType, QString timeLeft);

private:
    Label *mTimerType;
    Label *mTimeLeft;
};

#endif /* ACTIVEFRAME_H_ */
