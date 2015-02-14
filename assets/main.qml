import bb.cascades 1.0
import pomodoro.lib 1.0


NavigationPane {
    id: rootNavPane

    property int pomodoroCountBeforeLongBreak: 0
    property int totalPomodoroCount: 0
    property int totalWorkMinutes: 0
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
                    text: "Work Time!"
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
                    id: totalPomodoroCountLabel
                    text: "You worked for 0 Pomodoros."
                    textStyle {
                        fontSize: FontSize.Large
                    }
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }

                Label {
                    id: totalWorkHoursLabel
                    text: "That would be 0 hours 0 minutes."
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
                totalPomodoroCountLabel.text = "You worked for " + totalPomodoroCount + " Pomodoros."
                
                totalWorkMinutes += appSettings.pomodoroDuration
                totalWorkHoursLabel.text = "That would be " + Math.floor(totalWorkMinutes/60) + " hours " + (totalWorkMinutes % 60) + " minutes."

                if(pomodoroCountBeforeLongBreak >= appSettings.pomodorosBeforeLongBreak) {
                    timerTypeLabel.text = "Take a Long Break!"
                    currentTimerType = "LongBreakTimer"
                    timer.duration = appSettings.longBreakDuration
                    pomodoroCountBeforeLongBreak = 0
                } else {
                    timerTypeLabel.text = "Take a Short Break!"
                    currentTimerType = "ShortBreakTimer"
                    timer.duration = appSettings.shortBreakDuration
                }
            } else {
                timerTypeLabel.text = "Work Time!"
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
