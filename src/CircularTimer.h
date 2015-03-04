#ifndef CIRCULARTIMER_H
#define CIRCULARTIMER_H

#include <bb/cascades/Container>
#include <bb/cascades/CustomControl>
#include <bb/cascades/ImageView>
#include <bb/cascades/Image>
#include <bb/cascades/Label>
#include <bb/cascades/ImplicitAnimationController>

#include <QPair>
#include <QVector>
#include <QTime>
#include <QString>

using namespace bb::cascades;

class CircularTimer: public CustomControl
{
    Q_OBJECT

    Q_PROPERTY(float dimension READ dimension WRITE setDimension NOTIFY dimensionChanged)
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(int digitalTimerSize READ digitalTimerSize WRITE setDigitalTimerSize)

public:
    CircularTimer(Container *parent = 0);
    int duration() const;
    float dimension() const;
    int digitalTimerSize() const;
    Q_INVOKABLE QString timeLeft() const;
    Q_INVOKABLE bool isActive() const;

public slots:
    void setDimension(float dimension);
    void setDuration(int duration);
    void setDigitalTimerSize(int size);
    void start();
    void stop();

signals:
    void dimensionChanged(float dimension);
    void durationChanged(int duration);
    void timerStarted();
    void timerStopped();
    void timerCompleted();

private slots:
    void onDimensionChanged(float dimension);
    void onDurationChanged(int duration);
    void updateHands();

private:
    void timeout();
    void resetHandsWithoutAnimation();
    void resetHandsWithAnimation();

    Container* m_rootContainer;
    float m_dimension;

    static const int INITIAL_ANGLE;
    static const int SECOND_HAND_MOVEMENT_ANGLE;
    static const int DEFAULT_DURATION;
    static const float DEFAULT_DIMENSION;

    Image m_secondHand;
    ImageView* m_secondHandle;
    Container* m_secondHandleContainer;
    ImageView* m_secondDial;

    Container* m_minuteHandContainer;
    Image m_minuteHand;
    ImageView* m_minuteHandle;
    Container* m_minuteHandleContainer;
    ImageView* m_minuteDial;

    Label* m_digitalTime;

    int mDuration;
    double mMinuteHandMovementAngle;

    QTime m_startTime;
    QTime m_endTime;
    QTimer* m_updateTimer;
};

#endif // CIRCULARTIMER_H
