import bb.cascades 1.2

Container {
    layout: DockLayout {
    }
    background: Color.Black

    Container {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        background: Color.Black

        Label {
            objectName: "TimerType"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            text: ""
            textStyle.color: Color.White
            textStyle.fontSize: FontSize.Large
        }

        Label {
            objectName: "TimeLeft"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            text: ""
            textStyle.color: Color.White
            textStyle.fontSize: FontSize.Large
        }
    }
}
