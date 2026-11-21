import QtQuick

Item {
    id: root

    property string mood: "idle"
    property real characterSize: 220

    function startTalking() {
        mood = "talking"
        talkTimer.restart()
    }

    Rectangle {
        id: platform
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: Math.min(parent.width * 0.5, 180)
        height: 3
        radius: height / 2
        color: "#dfd9cb"
    }

    Image {
        id: petImage
        source: Qt.resolvedUrl("../assets/quail.svg")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: platform.top
        width: Math.min(root.characterSize, parent.width * 0.76)
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
            NumberAnimation { target: petImage; property: "scale"; to: 1.035; duration: 170; easing.type: Easing.OutQuad }
            NumberAnimation { target: petImage; property: "scale"; to: 0.99; duration: 170; easing.type: Easing.InOutQuad }
            PauseAnimation { duration: 120 }
            NumberAnimation { target: petImage; property: "scale"; to: 1; duration: 170; easing.type: Easing.InOutQuad }
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
            petImage.scale = 1
    }
}
