import bb.cascades 1.0
import pomodoro.lib 1.0


NavigationPane {
    id: rootNavPane

    property int pomodoroCountBeforeLongBreak: 0
    property int totalPomodoroCount: 0
    property string currentTimerType: "PomodoroTimer"

    attachedObjects: [
        ComponentDefinition {
            id: appSettingsPage
            source: 'SettingsPage.qml'
        }
    ]

    Menu.definition: MenuDefinition {
        helpAction: HelpActionItem {}
        settingsAction: SettingsActionItem {
            onTriggered: {
                var page = appSettingsPage.createObject()
                Application.menuEnabled = false
                rootNavPane.push(page)
            }
        }
    }

    Page {
        id: timerPage

        Container {
            layout: DockLayout {}

            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center

                Label {
                    id: timerTypeLabel
                    text: "Pomodoro Session"
                    textStyle {
                        fontSize: FontSize.XLarge
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }

                CircularTimer {
                    id: timer
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    duration: appSettings.pomodoroDuration
                }

                Label {
                    id: totalPomodoroCount
                    text: "Total Pomodoros for this session: 0"
                    textStyle {
                        fontSize: FontSize.Large
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }

                Label {
                    id: totalWorkHours
                    text: "You worked 0 hours"
                    textStyle {
                        fontSize: FontSize.Large
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
            }
        }

        actions:  [
            ActionItem {
                id: startAction
                title: "Start"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    timer.start()
                }
            },
            ActionItem {
                id: stopAction
                title: "Stop"
                ActionBar.placement: ActionBarPlacement.OnBar
                enabled: false
                onTriggered: {
                    if(timer.isActive())
                        timer.stop()
                }
            }
        ]

        function onTimerStarted() {
            Application.menuEnabled = false
            startAction.enabled = false
            stopAction.enabled = true
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

            if(currentTimerType == "PomodoroTimer") {
                pomodoroCountBeforeLongBreak += 1
                totalPomodoroCount += 1

                if(pomodoroCountBeforeLongBreak >= appSettings.pomodorosBeforeLongBreak) {
                    timerTypeLabel.text = "Long Break Time!"
                    currentTimerType = "LongBreakTimer"
                    timer.duration = appSettings.longBreakDuration
                    pomodoroCountBeforeLongBreak = 0
                } else {
                    timerTypeLabel.text = "Short Break Time!"
                    currentTimerType = "ShortBreakTimer"
                    timer.duration = appSettings.shortBreakDuration
                }
            } else {
                timerTypeLabel.text = "Pomodoro Time!"
                currentTimerType = "PomodoroTimer"
                timer.duration = appSettings.pomodoroDuration
            }
        }

        onCreationCompleted: {
            timer.timerStarted.connect(onTimerStarted)
            timer.timerStopped.connect(onTimerStopped)
            timer.timerCompleted.connect(onTimerCompleted)
        }
    }

    onPopTransitionEnded: {
        Application.menuEnabled = true

        if (currentTimerType === "PomodoroTimer")
            timer.duration = appSettings.pomodoroDuration
        else if (currentTimerType === "ShortBreakTimer")
            timer.duration = appSettings.shortBreakDuration
        else
            timer.duration = appSettings.longBreakDuration
    }
}
