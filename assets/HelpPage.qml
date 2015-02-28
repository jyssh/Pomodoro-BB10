import bb.cascades 1.2

Page {
    titleBar: TitleBar {
        title: "Help"
    }

    Container {
        topPadding: 10
        leftPadding: 10
        rightPadding: 10
        bottomPadding: 10        
        
        TextArea {
            editable: false
            inputMode: inputMode.Text
            leftPadding: 5
            rightPadding: 5

            text:   "<html>" + 
                        "<span style='font-size: medium; font-weight: bold;'> What is the app about? </span>" +

                        "<br/>" +
                        "<div>" +
                            "Pomodoro Timer app servers as a timer for the Pomodoro Technique, a famous time-management and productivity method developed by Francesco Cirillo. <br/>" +
                            "In this method, work is broken down into small tasks. Parallely, time is divided into chunks of several minutes (traditionally 25 minutes), each chunk called a Pomodoro. <br/>" +
                            "A task to be done may span one or several pomodori. Each pomodoro is followed by a short period of break. After certain number of pomodori, a break of longer period is taken. <br/>" +
                        "</div>" +
                        
                        "<br/>" +
                        "<div>" +
                            "The method can be followed in the following steps: <br/>" +
                            "1. Decide the task to be completed <br/>" +
                            "2. Start the pomodoro timer <br/>" +
                            "3. Work on the task until the timer rings. <br/>" +
                            "4. Take a short break. <br/>" +
                            "5. After certain amount of pomodori, take a long break. <br/>" +
                        "</div>" +
                        
                        "<br/>" +
                        "<div>" +
                            "The idea here is to concentrate only and only on the task during a Pomodoro. <br/>" +
                            "Any other distraction like a phone call are to be posptponed till the timer ends. They may be dealt with during the break time. <br/>" +
                            "If the distraction is unavoidable, then the Pomodoro has to be abandoned entirely. <br/>" +
                        "</div>" +
                        
                        "<br/>" +
                        "<span style='font-size: medium; font-weight: bold;'> How does the app work? </span>" +

                        "<br/>" +
                        "<div>" +
                            "The app provides settings to configure various aspects of the timer. <br/>" +
                            "You may change the durations and alert sounds of <br/>" +
                            "- Pomodoro timer<br/>" +
                            "- Short break timer <br/>" +
                            "- Long break timer <br/>" +
                            "Also, you may configure the number of pomodori after which the long break timer is triggered. <br/>" +
                            "I decided not to use sounds provided by BB10 OS in order to distinguish the alerts. <br/>" +
                        "</div>" +

                        "<br/>" +
                        "<div>" +
                            "Traditionally, the technique recommends a <br/>" +
                            "- 25-minutes Pomodoro <br/>" +
                            "- 5-minutes short break <br/>" +
                            "- 15-minutes long break <br/>" +
                            "- long break after 4 pomodori <br/>" +
                        "</div>" +

                        "<br/>" +
                        "<div>" +
                            "After configuring the timers to your liking, start using the timer as explained in the steps. <br/>" +
                            "I recommend turning on the 'Silent' or 'Phone Calls Only' profile while working. The app alerts are played regardless of the profile. <br/>" +
                            "True to the original method, there is no 'Pause' button, but only 'Stop' button to a timer. <br/>" +
                        "</div>" +

                        "<br/>" +
                        "<span style='font-size: medium; font-weight: bold;'> Active Frame </span>" +
                            
                        "<br/>" +
                        "<div>" + 
                            "When the app is minimized, the active frame displays the name of the current timer and the minutes left in the timer. <br/>" +
                        "</div>" +
                        
                        "<br/>" +
                        "<span style='font-size: medium; font-weight: bold;'> Why the Tomato Icon? </span>" +                        

                        "<br/>" +
                        "<div>" + 
                            "Pomodoro means tomato in Spanish. This technique was probably named after the mechanical kitchen timers, often shaped like tomatoes. <br/>" +
                        "</div>" +
                    "</html>"
        }
    }
}
