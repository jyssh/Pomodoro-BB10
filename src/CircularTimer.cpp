#include "CircularTimer.h"

#include <bb/cascades/AbsoluteLayout>
#include <bb/cascades/DockLayout>
#include <bb/cascades/Color>
#include <bb/cascades/FontSize>
#include <bb/cascades/ImplicitAnimationController>

#include "math.h"

#include <QSettings>
#include <QDebug>


const int CircularTimer::INITIAL_ANGLE = 270;
const int CircularTimer::SECOND_HAND_MOVEMENT_ANGLE = 6;
const int CircularTimer::DEFAULT_DURATION = 25;


CircularTimer::CircularTimer(Container *parent):
    CustomControl(parent),
    mDuration(DEFAULT_DURATION),
    m_startTime(0, 0, 0),
    m_endTime(0, DEFAULT_DURATION, 0),
    m_updateTimer(new QTimer(this))
{
    m_secondHand = Image(QUrl("asset:///images/handle_inactive.png"));
    m_secondHandle = ImageView::create()
            .image(m_secondHand)
            .horizontal(HorizontalAlignment::Right)
            .vertical(VerticalAlignment::Center);
    m_secondHandleContainer = Container::create()
            .layout(new DockLayout())
            .add(m_secondHandle);
    m_secondDial = ImageView::create().image(QUrl("asset:///images/slider_track.png"))
            .horizontal(HorizontalAlignment::Center)
            .vertical(VerticalAlignment::Center);

    m_minuteHand = Image(QUrl("asset:///images/handle_inactive.png"));
    m_minuteHandle = ImageView::create()
            .image(m_minuteHand)
            .horizontal(HorizontalAlignment::Right)
            .vertical(VerticalAlignment::Center);
    m_minuteHandleContainer = Container::create()
            .layout(new DockLayout())
            .add(m_minuteHandle);
    m_minuteDial = ImageView::create().image(QUrl("asset:///images/slider_track.png"))
            .horizontal(HorizontalAlignment::Center)
            .vertical(VerticalAlignment::Center);
    m_minuteHandContainer = Container::create().layout(new DockLayout())
            .horizontal(HorizontalAlignment::Center)
            .vertical(VerticalAlignment::Center)
            .add(m_minuteDial)
            .add(m_minuteHandleContainer);

    m_digitalTime = Label::create()
            .horizontal(HorizontalAlignment::Center)
            .vertical(VerticalAlignment::Center);
    m_digitalTime->textStyle()->setFontSize(FontSize::XXLarge);

    m_rootContainer = Container::create()
            .layout(new DockLayout())
            .add(m_secondDial)
            .add(m_secondHandleContainer)
            .add(m_minuteHandContainer)
            .add(m_digitalTime);
    setRoot(m_rootContainer);

    bool ok;
    ok = QObject::connect(this, SIGNAL(preferredHeightChanged(float)), this, SLOT(onHeightChanged(float)));
    Q_ASSERT(ok);
    ok = QObject::connect(this, SIGNAL(preferredWidthChanged(float)), this, SLOT(onWidthChanged(float)));
    Q_ASSERT(ok);
    ok = QObject::connect(this, SIGNAL(durationChanged(int)), this, SLOT(onDurationChanged(int)));
    Q_ASSERT(ok);

    m_width = 700;
    m_height = 700;
    setPreferredSize(m_width, m_height);

    setDuration(mDuration);

    ok = QObject::connect(m_updateTimer, SIGNAL(timeout()), this, SLOT(updateHands()));
    Q_ASSERT(ok);
}

void CircularTimer::onWidthChanged(float width)
{
    m_width = width;
    onSizeChanged();
}

void CircularTimer::onHeightChanged(float height)
{
    m_height = height;
    onSizeChanged();
}

void CircularTimer::onSizeChanged()
{
    m_rootContainer->setPreferredSize(m_width, m_height);
    m_secondDial->setPreferredSize(m_width * 0.85, m_height * 0.85);
    m_secondHandle->setPreferredSize(m_width * 0.2, m_height * 0.2);
    m_secondHandleContainer->setPreferredSize(m_width, m_height * 0.2);
    m_secondHandleContainer->setTranslationY((m_height - 0.2 * m_height) / 2);
    m_secondHandleContainer->setRotationZ(INITIAL_ANGLE);

    float width = m_width * 0.70;
    float height = m_height * 0.70;
    m_minuteHandContainer->setPreferredSize(width, height);
    m_minuteDial->setPreferredSize(width * 0.85, height * 0.85);
    m_minuteHandle->setPreferredSize(width * 0.2, height * 0.2);
    m_minuteHandleContainer->setPreferredSize(width, height * 0.2);
    m_minuteHandleContainer->setTranslationY((height - 0.2 * height) / 2);
    m_minuteHandleContainer->setRotationZ(INITIAL_ANGLE);
}

void CircularTimer::updateHands()
{
    int elapsedSecs = m_startTime.secsTo(QTime::currentTime());
    QTime elapsedTime = QTime(0, 0, 0).addSecs(elapsedSecs);
    int secondsLeft = elapsedTime.secsTo(m_endTime);
    if(secondsLeft >= 0) {
        QTime timeLeft = QTime(0, 0, 0).addSecs(secondsLeft);
        m_digitalTime->setText(timeLeft.toString("mm.ss"));

        m_secondHandleContainer->setRotationZ(m_secondHandleContainer->rotationZ() + SECOND_HAND_MOVEMENT_ANGLE);

        double minuteMovement = elapsedTime.minute() * mMinuteHandMovementAngle + 270;
        if (minuteMovement > (360 + 270))
            m_minuteHandleContainer->setRotationZ(360 + 270);
        else
            m_minuteHandleContainer->setRotationZ(minuteMovement);
    } else {
        timeout();
    }
}

int CircularTimer::duration() const
{
    return mDuration;
}

void CircularTimer::setDuration(int duration)
{
    mDuration = duration;
    emit durationChanged(duration);
}

void CircularTimer::start()
{
    resetHandsWithoutAnimation();
    m_startTime.start();
    m_updateTimer->start(1000);
    emit timerStarted();
}

void CircularTimer::stop()
{
    m_updateTimer->stop();
    m_digitalTime->setText(m_endTime.toString("mm.ss"));
    resetHandsWithAnimation();
    emit timerStopped();
}

void CircularTimer::timeout()
{
    m_updateTimer->stop();
    m_digitalTime->setText(m_endTime.toString("mm.ss"));
    emit timerCompleted();
}

void CircularTimer::onDurationChanged(int duration)
{
    m_startTime.setHMS(0, 0, 0);
    m_endTime.setHMS(0, duration, 0);
    m_digitalTime->setText(m_endTime.toString("mm.ss"));
    mMinuteHandMovementAngle = 360 / (double) duration;
}

bool CircularTimer::isActive() const
{
    return m_updateTimer->isActive();
}

void CircularTimer::resetHandsWithoutAnimation()
{
    if(m_secondHandleContainer->rotationZ() != INITIAL_ANGLE) {
        ImplicitAnimationController secondController = ImplicitAnimationController::create(m_secondHandleContainer).enabled(false);
        m_secondHandleContainer->setRotationZ(INITIAL_ANGLE);
    }
    if(m_minuteHandleContainer->rotationZ() != INITIAL_ANGLE) {
        ImplicitAnimationController minuteController = ImplicitAnimationController::create(m_minuteHandleContainer).enabled(false);
        m_minuteHandleContainer->setRotationZ(INITIAL_ANGLE);
    }
}

void CircularTimer::resetHandsWithAnimation()
{
    if(m_secondHandleContainer->rotationZ() != INITIAL_ANGLE) {
        m_secondHandleContainer->setRotationZ(INITIAL_ANGLE);
    }
    if(m_minuteHandleContainer->rotationZ() != INITIAL_ANGLE) {
        m_minuteHandleContainer->setRotationZ(INITIAL_ANGLE);
    }
}
