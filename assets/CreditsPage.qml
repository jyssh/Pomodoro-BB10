import bb.cascades 1.2

Page {
    titleBar: TitleBar {
        title: "Credits"
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
            text: "The alert sounds are recorded by Mike Koenig and KevanGC. The original versions can be found at www.soundbible.com."
        }
        
    }
}
