import bb.cascades 1.3
import bb.device 1.2
import bb.multimedia 1.2
import pomodoro.lib 1.0
import bb.device 1.4

NavigationPane {
    id: rootNavPane

    property string workTitle: "Work Time"
    property string shortBreakTitle: "Short Break"
    property string longBreakTitle: "Long Break"

    property string workTimerType: "PomorodoTimer"
    property string shortBreakTimerType: "ShortBreakTimer"
    property string longBreakTimerType: "LongBreakTimer"

    property int pomodoroCountBeforeLongBreak: 0
    property int totalPomodoroCount: 0
    property int totalWorkMinutes: 0
    property string currentTimerType: workTimerType

    property bool isActiveFrame: false
    
    attachedObjects: [
        ComponentDefinition {
            id: appSettingsPage
            source: "SettingsPage.qml"
        },
        ComponentDefinition {
            id: helpPage
            source: "HelpPage.qml"
        },
        ComponentDefinition {
            id: creditsPage
            source: "CreditsPage.qml"
        },
        MediaPlayer {
            id: mediaPlayer
        },
        VibrationController {
            id: vibrationAlert
        },
        QTimer {
            id: activeFrameTimer
            singleShot: true
            interval: 60000
            onTimeout: {
                updateActiveFrame()
            }
        },
        DisplayInfo {
            id: displayInfo
        }
    ]

    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {
            onTriggered: {
                var page = helpPage.createObject()
                Application.menuEnabled = false
                rootNavPane.push(page)
            }
        }
        settingsAction: SettingsActionItem {
            onTriggered: {
                var page = appSettingsPage.createObject()
                Application.menuEnabled = false
                rootNavPane.push(page)
            }
        }
        actions: [
            ActionItem {
                title: "Credits"
                imageSource: "asset:///images/info.png"
                onTriggered: {
                    var page = creditsPage.createObject()
                    Application.menuEnabled = false
                    rootNavPane.push(page)
                }
            }
        ]
    }

    Page {
        id: timerPage

        Container {
            layout: DockLayout {
            }

            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center

                Label {
                    id: timerTypeLabel
                    text: workTitle
                    textStyle {
                        fontSize: is720() ? FontSize.Medium : FontSize.XLarge
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }

                CircularTimer {
                    id: timer
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    dimension: is720() ? 400 : 700
                    duration: appSettings.pomodoroDuration
                    digitalTimerSize: is720() ? FontSize.Large : FontSize.XXLarge
                }

                Label {
                    id: totalPomodoroCountLabel
                    topMargin: 2
                    bottomMargin: 3
                    text: "You have worked for 0 Pomodoro."
                    textStyle {
                        fontSize: is720() ? FontSize.XSmall : FontSize.Large
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }

                Label {
                    id: totalWorkHoursLabel
                    topMargin: 3
                    text: "That is 0 hour 0 minute."
                    textStyle {
                        fontSize: is720() ? FontSize.XSmall : FontSize.Large
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
            }
        }

        actions: [
            ActionItem {
                id: startAction
                title: "Start"
                imageSource: "asset:///images/start.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    timer.start()
                }
            },
            ActionItem {
                id: stopAction
                title: "Stop"
                imageSource: "asset:///images/stop.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                enabled: false
                onTriggered: {
                    if (timer.isActive())
                        timer.stop()
                }
            }
        ]

        function onTimerStarted() {
            Application.menuEnabled = false
            startAction.enabled = false
            stopAction.enabled = true

            if (currentTimerType === workTimerType)
                mediaPlayer.sourceUrl = appSettings.workTimeoutSound;
            else if (currentTimerType === shortBreakTimerType)
                mediaPlayer.sourceUrl = appSettings.shortBreakTimeoutSound;
            else
                mediaPlayer.sourceUrl = appSettings.longBreakTimeoutSound
        }

        function onTimerStopped() {
            Application.menuEnabled = true
            startAction.enabled = true
            stopAction.enabled = false
        }

        function onTimerCompleted() {
            Application.menuEnabled = true
            startAction.enabled = true
            stopAction.enabled = false

            mediaPlayer.play()

            if (currentTimerType == workTimerType) {
                pomodoroCountBeforeLongBreak += 1

                totalPomodoroCount += 1
                totalPomodoroCountLabel.text = "You have worked for " + totalPomodoroCount + " Pomodori."

                totalWorkMinutes += appSettings.pomodoroDuration
                totalWorkHoursLabel.text = "That is " + Math.floor(totalWorkMinutes / 60) + " hours " + (totalWorkMinutes % 60) + " minutes."

                if (pomodoroCountBeforeLongBreak >= appSettings.pomodorosBeforeLongBreak) {
                    timerTypeLabel.text = longBreakTitle
                    currentTimerType = longBreakTimerType
                    timer.duration = appSettings.longBreakDuration
                    pomodoroCountBeforeLongBreak = 0
                } else {
                    timerTypeLabel.text = shortBreakTitle
                    currentTimerType = shortBreakTimerType
                    timer.duration = appSettings.shortBreakDuration
                }
            } else {
                timerTypeLabel.text = workTitle
                currentTimerType = workTimerType
                timer.duration = appSettings.pomodoroDuration
            }

            if (vibrationAlert.isSupported())
                vibrationAlert.start(100, 2400)
        }

        onCreationCompleted: {
            timer.timerStarted.connect(onTimerStarted)
            timer.timerStopped.connect(onTimerStopped)
            timer.timerCompleted.connect(onTimerCompleted)
        }
    }

    onPopTransitionEnded: {
        Application.menuEnabled = true

        if (currentTimerType === workTimerType) {
            timer.duration = appSettings.pomodoroDuration
        } else if (currentTimerType === shortBreakTimerType) {
            timer.duration = appSettings.shortBreakDuration
        } else {
            timer.duration = appSettings.longBreakDuration
        }
    }

    onCreationCompleted: {
        Application.thumbnail.connect(backgrounded)
        Application.fullscreen.connect(foregrounded)
    }

    function foregrounded() {
        isActiveFrame = false
        activeFrameTimer.stop()
    }

    function backgrounded() {
        isActiveFrame = true
        updateActiveFrame()
    }

    function updateActiveFrame() {
        if (isActiveFrame) {
            activeFrameTimer.start()

            var minsLeft = parseInt(timer.timeLeft().split(".")[0], 10)
            var txt = ''
            if (minsLeft > 0)
                txt = '~ ' + minsLeft.toString() + " mins left"
            else
                txt = '< 1 min left'
            
            activeFrame.update(timerTypeLabel.text, txt)
        }
    }
    
    function is720() {
        return displayInfo.pixelSize.width === 720 && displayInfo.pixelSize.height === 720
    }
}
