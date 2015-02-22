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
    Q_PROPERTY(QString workTimeoutSound READ workTimeoutSound WRITE setWorkTimeoutSound NOTIFY workTimeoutSoundChanged FINAL)
    Q_PROPERTY(QString shortBreakTimeoutSound READ shortBreakTimeoutSound WRITE setShortBreakTimeoutSound NOTIFY shortBreakTimeoutSoundChanged FINAL)
    Q_PROPERTY(QString longBreakTimeoutSound READ longBreakTimeoutSound WRITE setLongBreakTimeoutSound NOTIFY longBreakTimeoutSoundChanged FINAL)

public:
    explicit AppSettings(QObject *parent = 0);
    ~AppSettings();

    int pomodoroDuration() const;
    int shortBreakDuration() const;
    int longBreakDuration() const;
    int pomodorosBeforeLongBreak() const;
    QString workTimeoutSound() const;
    QString shortBreakTimeoutSound() const;
    QString longBreakTimeoutSound() const;

public slots:
    void setPomodoroDuration(int duration);
    void setShortBreakDuration(int duration);
    void setLongBreakDuration(int duration);
    void setPomodorosBeforeLongBreak(int count);
    void setWorkTimeoutSound(QString url);
    void setShortBreakTimeoutSound(QString url);
    void setLongBreakTimeoutSound(QString url);

signals:
    void pomodoroDurationChanged(int duration);
    void shortBreakDurationChanged(int duration);
    void longBreakDurationChanged(int duration);
    void pomodorosBeforeLongBreakChanged(int count);
    void workTimeoutSoundChanged(QString url);
    void shortBreakTimeoutSoundChanged(QString url);
    void longBreakTimeoutSoundChanged(QString url);

private:
    static const QString POMODORO_DURATION;
    static const QString SHORT_BREAK_DURATION;
    static const QString LONG_BREAK_DURATION;
    static const QString POMODOROS_BEFORE_LONG_BREAK;
    static const QString WORK_TIMEOUT_SOUND;
    static const QString SHORT_BREAK_TIMEOUT_SOUND;
    static const QString LONG_BREAK_TIMEOUT_SOUND;

    int mPomodoroDuration;
    int mShortBreakDuration;
    int mLongBreakDuration;
    int mPomodorosBeforeLongBreak;
    QString mWorkTimeoutSound;
    QString mShortBreakTimeoutSound;
    QString mLongBreakTimeoutSound;
};

#endif // APPSETTINGS_H
