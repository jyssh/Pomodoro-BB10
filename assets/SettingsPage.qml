import bb.cascades 1.2
import bb.multimedia 1.2

Page {
    titleBar: TitleBar {
        title: "Settings"
    }

    attachedObjects: [
        MediaPlayer {
            id: testPlayer
        }
    ]

    Container {
        ScrollView {
            scrollViewProperties {
                scrollMode: ScrollMode.Vertical
            }

            Container {
                id: settingsContainer

                layout: StackLayout {
                }

                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                bottomPadding: 20

                DropDown {
                    id: pomodoroDurationSelector
                    title: "Pomodoro Duration"

                    Option {
                        value: 25
                        text: "25 minutes"
                    }
                    Option {
                        value: 30
                        text: "30 minutes"
                    }
                    Option {
                        value: 35
                        text: "35 minutes"
                    }
                    Option {
                        value: 40
                        text: "40 minutes"
                    }
                    Option {
                        value: 45
                        text: "45 minutes"
                    }
                    Option {
                        value: 50
                        text: "50 minutes"
                    }
                    Option {
                        value: 55
                        text: "55 minutes"
                    }
                    Option {
                        value: 60
                        text: "60 minutes"
                    }

                    onSelectedValueChanged: {
                        appSettings.pomodoroDuration = selectedValue
                    }

                    onCreationCompleted: {
                        if (! settingsContainer.setDropDownOptionByValue(pomodoroDurationSelector, appSettings.pomodoroDuration))
                            setSelectedIndex(0)
                    }
                }

                DropDown {
                    id: shortBreakDurationSelector
                    title: "Short Break Duration"

                    Option {
                        value: 5
                        text: "5 minutes"
                        selected: true
                    }
                    Option {
                        value: 10
                        text: "10 minutes"
                    }
                    Option {
                        value: 15
                        text: "15 minutes"
                    }
                    Option {
                        value: 20
                        text: "20 minutes"
                    }

                    onSelectedValueChanged: {
                        appSettings.shortBreakDuration = selectedValue
                    }

                    onCreationCompleted: {
                        if (! settingsContainer.setDropDownOptionByValue(shortBreakDurationSelector, appSettings.shortBreakDuration))
                            setSelectedIndex(0);
                    }
                }

                DropDown {
                    id: longBreakDurationSelector
                    title: "Long Break Duration"

                    Option {
                        value: 15
                        text: "15 minutes"
                        selected: true
                    }
                    Option {
                        value: 20
                        text: "20 minutes"
                    }
                    Option {
                        value: 25
                        text: "25 minutes"
                    }
                    Option {
                        value: 30
                        text: "30 minutes"
                    }

                    onSelectedValueChanged: {
                        appSettings.longBreakDuration = selectedValue
                    }

                    onCreationCompleted: {
                        if (! settingsContainer.setDropDownOptionByValue(longBreakDurationSelector, appSettings.longBreakDuration))
                            setSelectedIndex(0)
                    }
                }

                Divider {
                    accessibility.name: "Section Break"
                }

                DropDown {
                    id: pomodorosBeforeLongBreakSelector
                    title: "Long Break After"

                    Option {
                        value: 3
                        text: "3 Pomodoros"
                    }
                    Option {
                        value: 4
                        text: "4 Pomodoros"
                        selected: true
                    }
                    Option {
                        value: 5
                        text: "5 Pomodoros"
                    }
                    Option {
                        value: 6
                        text: "6 Pomodoros"
                    }

                    onSelectedValueChanged: {
                        appSettings.pomodorosBeforeLongBreak = selectedValue
                    }

                    onCreationCompleted: {
                        if (! settingsContainer.setDropDownOptionByValue(pomodorosBeforeLongBreakSelector, appSettings.pomodorosBeforeLongBreak))
                            setSelectedIndex(0)
                    }
                }

                Divider {
                    accessibility.name: "Section Break"
                }

                DropDown {
                    id: workTimeoutSoundSelector
                    title: "Work session timeout"

                    Option {
                        text: "Strange Alarm"
                        value: _publicDir + "sounds/strange-alarm.mp3"
                    }
                    Option {
                        text: "Ship Bell"
                        value: _publicDir + "sounds/ship-bell.mp3"
                    }
                    Option {
                        text: "Temple Bell"
                        value: _publicDir + "sounds/temple-bell.mp3"
                    }
                    Option {
                        text: "Japanese Temple Bell"
                        value: _publicDir + "sounds/japanese-temple-bell.mp3"
                    }
                    Option {
                        text: "Zen Temple Bell"
                        value: _publicDir + "sounds/zen-temple-bell.mp3"
                    }

                    onSelectedValueChanged: {
                        appSettings.workTimeoutSound = selectedValue
                        if (workTimeoutSoundSelector.focused) {
                            testPlayer.sourceUrl = selectedValue
                            testPlayer.play()
                        }
                    }

                    onCreationCompleted: {
                        if (! settingsContainer.setDropDownOptionByValue(workTimeoutSoundSelector, appSettings.workTimeoutSound))
                            setSelectedIndex(0)
                    }
                }

                DropDown {
                    id: shortBreakTimeoutSoundSelector
                    title: "Short Break timeout"

                    Option {
                        text: "Strange Alarm"
                        value: _publicDir + "sounds/strange-alarm.mp3"
                    }
                    Option {
                        text: "Ship Bell"
                        value: _publicDir + "sounds/ship-bell.mp3"
                    }
                    Option {
                        text: "Temple Bell"
                        value: _publicDir + "sounds/temple-bell.mp3"
                    }
                    Option {
                        text: "Japanese Temple Bell"
                        value: _publicDir + "sounds/japanese-temple-bell.mp3"
                    }
                    Option {
                        text: "Zen Temple Bell"
                        value: _publicDir + "sounds/zen-temple-bell.mp3"
                    }

                    onSelectedValueChanged: {
                        appSettings.shortBreakTimeoutSound = selectedValue
                        if (shortBreakTimeoutSoundSelector.focused) {
                            testPlayer.sourceUrl = selectedValue
                            testPlayer.play()
                        }
                    }

                    onCreationCompleted: {
                        if (! settingsContainer.setDropDownOptionByValue(shortBreakTimeoutSoundSelector, appSettings.shortBreakTimeoutSound))
                            setSelectedIndex(0)
                    }
                }

                DropDown {
                    id: longBreakTimeoutSoundSelector
                    title: "Long Break timeout"

                    Option {
                        text: "Strange Alarm"
                        value: _publicDir + "sounds/strange-alarm.mp3"
                    }
                    Option {
                        text: "Ship Bell"
                        value: _publicDir + "sounds/ship-bell.mp3"
                    }
                    Option {
                        text: "Temple Bell"
                        value: _publicDir + "sounds/temple-bell.mp3"
                    }
                    Option {
                        text: "Japanese Temple Bell"
                        value: _publicDir + "sounds/japanese-temple-bell.mp3"
                    }
                    Option {
                        text: "Zen Temple Bell"
                        value: _publicDir + "sounds/zen-temple-bell.mp3"
                    }

                    onSelectedValueChanged: {
                        appSettings.longBreakTimeoutSound = selectedValue
                        if (longBreakTimeoutSoundSelector.focused) {
                            testPlayer.sourceUrl = selectedValue
                            testPlayer.play()
                        }
                    }

                    onCreationCompleted: {
                        if (! settingsContainer.setDropDownOptionByValue(longBreakTimeoutSoundSelector, appSettings.longBreakTimeoutSound))
                            setSelectedIndex(0)
                    }
                }

                function setDropDownOptionByValue(dropdown, value) {
                    for (var i = 0; i < dropdown.options.length; ++ i) {
                        var option = dropdown.options[i];
                        if (option.value === value) {
                            dropdown.setSelectedOption(option);
                            return true;
                        }
                    }
                    return false;
                }
            }
        }
    }
}
