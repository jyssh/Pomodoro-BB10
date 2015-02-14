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

using namespace bb::cascades;

class CircularTimer: public CustomControl
{
    Q_OBJECT

    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)

public:
    CircularTimer(Container *parent = 0);
    int duration() const;
    Q_INVOKABLE bool isActive() const;

public slots:
    void setDuration(int duration);
    void start();
    void stop();

signals:
    void durationChanged(int duration);
    void timerStarted();
    void timerStopped();
    void timerCompleted();

private slots:
    void onDurationChanged(int duration);
    void onHeightChanged(float width);
    void onWidthChanged(float width);
    void updateHands();

private:
    void onSizeChanged();
    void timeout();
    void resetHandsWithoutAnimation();
    void resetHandsWithAnimation();

    Container* m_rootContainer;
    float m_width;
    float m_height;

    static const int INITIAL_ANGLE;
    static const int SECOND_HAND_MOVEMENT_ANGLE;
    static const int DEFAULT_DURATION;

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

    QTimer* m_updateTimer;
    QTime m_startTime;
    QTime m_endTime;

    double mMinuteHandMovementAngle;
    int mDuration;
};

#endif // CIRCULARTIMER_H
