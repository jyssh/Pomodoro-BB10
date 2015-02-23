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
        id: settingsContainer

        topPadding: 10
        leftPadding: 10
        rightPadding: 10
        bottomPadding: 10

        DropDown {
            id: pomodoroDurationSelector
            title: "Pomodoro Duration"
            Option {
                value: 1
                text: "1 minutes"
            }

            Option {
                value: 2
                text: "2 minutes"
            }
            
            Option {
                value: 7
                text: "7 minutes"
            }

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

            onSelectedValueChanged: {
                appSettings.pomodoroDuration = selectedValue
            }

            onCreationCompleted: {
                if(appSettings.pomodoroDuration === 0)
                    setSelectedIndex(0);
                else
                    settingsContainer.setDropDownOptionByValue(pomodoroDurationSelector, appSettings.pomodoroDuration);
            }
        }

        DropDown {
            id: shortBreakDurationSelector
            title: "Short Break Duration"
            Option {
                value: 1
                text: "1 minutes"
            }

            Option {
                value: 5
                text: "5 minutes"
                selected: true
            }
            Option {
                value: 10
                text: "10 minutes"
            }

            onSelectedValueChanged: {
                appSettings.shortBreakDuration = selectedValue
            }

            onCreationCompleted: {
                if(appSettings.shortBreakDuration === 0)
                    setSelectedIndex(0);
                else
                    settingsContainer.setDropDownOptionByValue(shortBreakDurationSelector, appSettings.shortBreakDuration);
            }
        }

        DropDown {
            id: longBreakDurationSelector
            title: "Long Break Duration"
            Option {
                value: 1
                text: "1 minutes"
            }

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

            onSelectedValueChanged: {
                appSettings.longBreakDuration = selectedValue
            }

            onCreationCompleted: {
                if(appSettings.longBreakDuration === 0)
                    setSelectedIndex(0)
                else
                    settingsContainer.setDropDownOptionByValue(longBreakDurationSelector, appSettings.longBreakDuration)
            }
        }

        Divider { }

        DropDown {
            id: pomodorosBeforeLongBreakSelector
            title: "Long Break After"
            Option {
                value: 2
                text: "2 Pomodoros"
            }

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
                if(appSettings.pomodorosBeforeLongBreak === 0)
                    setSelectedIndex(0)
                else
                    settingsContainer.setDropDownOptionByValue(pomodorosBeforeLongBreakSelector, appSettings.pomodorosBeforeLongBreak)
            }
        }

        Divider { }
        
        DropDown {
            id: workTimeoutSoundSelector
            title: "Work session timeout"
            
            Option {
                text: "Alien Alarm"
                value: "asset:///sounds/alien-alarm.mp3"
            }
            Option {
                text: "Strange Alarm"
                value: "asset:///sounds/strange-alarm.mp3"
            }
            Option {
                text: "Glass Ping"
                value: "asset:///sounds/glass-ping.mp3"
            }
            Option {
                text: "Ship Bell"
                value: "asset:///sounds/ship-bell.mp3"
            }
            Option {
                text: "Temple Bell"
                value: "asset:///sounds/temple-bell.mp3"
            }
            Option {
                text: "Japanese Temple Bell"
                value: "asset:///sounds/japanese-temple-bell.mp3"
            }
            Option {
                text: "Zen Temple Bell"
                value: "asset:///sounds/zen-temple-bell.mp3"
            }
            
            onSelectedValueChanged: {
                appSettings.workTimeoutSound = selectedValue
                if (workTimeoutSoundSelector.focused) {
                    testPlayer.sourceUrl = selectedValue
                    testPlayer.play()
                }
            }

            onCreationCompleted: {
                settingsContainer.setDropDownOptionByValue(workTimeoutSoundSelector, appSettings.workTimeoutSound)
            }
        }
        
        DropDown {
            id: shortBreakTimeoutSoundSelector
            title: "Short Break timeout"
            
            Option {
                text: "Alien Alarm"
                value: "asset:///sounds/alien-alarm.mp3"
            }
            Option {
                text: "Strange Alarm"
                value: "asset:///sounds/strange-alarm.mp3"
            }
            Option {
                text: "Glass Ping"
                value: "asset:///sounds/glass-ping.mp3"
            }
            Option {
                text: "Ship Bell"
                value: "asset:///sounds/ship-bell.mp3"
            }
            Option {
                text: "Temple Bell"
                value: "asset:///sounds/temple-bell.mp3"
            }
            Option {
                text: "Japanese Temple Bell"
                value: "asset:///sounds/japanese-temple-bell.mp3"
            }
            Option {
                text: "Zen Temple Bell"
                value: "asset:///sounds/zen-temple-bell.mp3"
            }            
            
            onSelectedValueChanged: {
                appSettings.shortBreakTimeoutSound = selectedValue
                if (shortBreakTimeoutSoundSelector.focused) {
                    testPlayer.sourceUrl = selectedValue
                    testPlayer.play()
                }
            }

            onCreationCompleted: {
                settingsContainer.setDropDownOptionByValue(shortBreakTimeoutSoundSelector, appSettings.shortBreakTimeoutSound)
            }
        }
        
        DropDown {
            id: longBreakTimeoutSoundSelector
            title: "Long Break timeout"
            
            Option {
                text: "Alien Alarm"
                value: "asset:///sounds/alien-alarm.mp3"
            }
            Option {
                text: "Strange Alarm"
                value: "asset:///sounds/strange-alarm.mp3"
            }
            Option {
                text: "Glass Ping"
                value: "asset:///sounds/glass-ping.mp3"
            }
            Option {
                text: "Ship Bell"
                value: "asset:///sounds/ship-bell.mp3"
            }
            Option {
                text: "Temple Bell"
                value: "asset:///sounds/temple-bell.mp3"
            }
            Option {
                text: "Japanese Temple Bell"
                value: "asset:///sounds/japanese-temple-bell.mp3"
            }
            Option {
                text: "Zen Temple Bell"
                value: "asset:///sounds/zen-temple-bell.mp3"
            }
            
            onSelectedValueChanged: {
                appSettings.longBreakTimeoutSound = selectedValue
                if (longBreakTimeoutSoundSelector.focused) {
                    testPlayer.sourceUrl = selectedValue
                    testPlayer.play()
                }
            }

            onCreationCompleted: {
                settingsContainer.setDropDownOptionByValue(longBreakTimeoutSoundSelector, appSettings.longBreakTimeoutSound)
            }
        }
        
        Label {
            text: "The sounds are recorded by Mike Koenig and KevanGC."
        }

        function setDropDownOptionByValue(dropdown, value) {
            for(var i = 0; i < dropdown.options.length; ++i) {
                var option = dropdown.options[i];
                if(option.value === value) {
                    dropdown.setSelectedOption(option);
                    return true;
                }
            }
            return false;
        }
    }
}

