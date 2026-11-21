import QtQuick

Item {
    id: root

    property string mood: "idle"

    function startTalking() {
        mood = "talking"
        talkTimer.restart()
    }

    Image {
        id: bird
        source: Qt.resolvedUrl("../bird.svg")
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.76, parent.height * 0.9, 300)
        height: width
        fillMode: Image.PreserveAspectFit
        smooth: true
        transformOrigin: Item.Bottom

        Translate { id: bob }

        SequentialAnimation {
            running: root.mood === "idle"
            loops: Animation.Infinite
            NumberAnimation { target: bob; property: "y"; to: -5; duration: 1300; easing.type: Easing.InOutSine }
            NumberAnimation { target: bob; property: "y"; to: 0; duration: 1300; easing.type: Easing.InOutSine }
        }

        SequentialAnimation {
            id: talkingAnimation
            running: root.mood === "talking"
            loops: Animation.Infinite
            NumberAnimation { target: bird; property: "scale"; to: 1.035; duration: 170; easing.type: Easing.OutQuad }
            NumberAnimation { target: bird; property: "scale"; to: 0.99; duration: 170; easing.type: Easing.InOutQuad }
            PauseAnimation { duration: 120 }
            NumberAnimation { target: bird; property: "scale"; to: 1; duration: 170; easing.type: Easing.InOutQuad }
            PauseAnimation { duration: 360 }
        }
    }

    Timer {
        id: talkTimer
        interval: 1500
        onTriggered: root.mood = "idle"
    }

    onMoodChanged: {
        if (mood === "talking")
            talkTimer.restart()
        else
            bird.scale = 1
    }
}
