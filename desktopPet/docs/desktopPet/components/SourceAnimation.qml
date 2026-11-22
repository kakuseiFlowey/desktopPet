import QtQuick

Item {
    id: root

    property string mood: "idle"
    property int index: 0
    property url imgsource: Qt.resolvedUrl("../assets/quail.png")

    signal talkingFinished

    function getSource() {
        if (mood === "talking") {
            switch (index) {
            case 0:
                return Qt.resolvedUrl("../assets/speak1.png")
            case 1:
                return Qt.resolvedUrl("../assets/speak2.png")
            }
        }

        return Qt.resolvedUrl("../assets/quail.png")
    }

    function startTalkingAnimation() {
        index = 0
        imgsource = getSource()
        talkingAnimation.restart()
        talkingDuration.restart()
    }

    onMoodChanged: {
        imgsource = getSource()
        if (mood !== "talking") {
            index = 0
            talkingDuration.stop()
        }
    }

    onIndexChanged: imgsource = getSource()

    SequentialAnimation {
        id: talkingAnimation
        running: root.mood === "talking"
        loops: Animation.Infinite

        ScriptAction { script: root.index = 0 }
        PauseAnimation { duration: 300 }
        ScriptAction { script: root.index = 1 }
        PauseAnimation { duration: 300 }
    }

    Timer {
        id: talkingDuration
        interval: 4000
        onTriggered: root.talkingFinished()
    }
}
