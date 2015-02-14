#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QObject>
#include <QString>

class AppSettings : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int pomodoroDuration READ pomodoroDuration WRITE setPomodoroDuration NOTIFY pomodoroDurationChanged FINAL)
    Q_PROPERTY(int shortBreakDuration READ shortBreakDuration WRITE setShortBreakDuration NOTIFY shortBreakDurationChanged FINAL)
    Q_PROPERTY(int longBreakDuration READ longBreakDuration WRITE setLongBreakDuration NOTIFY longBreakDurationChanged FINAL)
    Q_PROPERTY(int pomodorosBeforeLongBreak READ pomodorosBeforeLongBreak WRITE setPomodorosBeforeLongBreak NOTIFY pomodorosBeforeLongBreakChanged FINAL)

public:
    explicit AppSettings(QObject *parent = 0);
    ~AppSettings();

    int pomodoroDuration() const;
    int shortBreakDuration() const;
    int longBreakDuration() const;
    int pomodorosBeforeLongBreak() const;

public slots:
    void setPomodoroDuration(int duration);
    void setShortBreakDuration(int duration);
    void setLongBreakDuration(int duration);
    void setPomodorosBeforeLongBreak(int count);

signals:
    void pomodoroDurationChanged(int duration);
    void shortBreakDurationChanged(int duration);
    void longBreakDurationChanged(int duration);
    void pomodorosBeforeLongBreakChanged(int count);

private:
    static const QString POMODORO_DURATION;
    static const QString SHORT_BREAK_DURATION;
    static const QString LONG_BREAK_DURATION;
    static const QString POMODOROS_BEFORE_LONG_BREAK;

    int mPomodoroDuration;
    int mShortBreakDuration;
    int mLongBreakDuration;
    int mPomodorosBeforeLongBreak;
};

#endif // APPSETTINGS_H
