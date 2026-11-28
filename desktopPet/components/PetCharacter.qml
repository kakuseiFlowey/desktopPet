import QtQuick

Item {
    id: root

    property string mood: "idle"
    property bool active: false
    property real characterSize: 220

    function startTalking() {
        mood = "talking"
        sourceAnimation.startTalkingAnimation()
    }

    function stopTalking() {
        mood = "idle"
    }

    SourceAnimation {
        id: sourceAnimation
        mood: root.mood
        onTalkingFinished: root.mood = "idle"
    }

    TouchAnimation {
        id: touchAnimation
        active: root.active
        baseSource: sourceAnimation.imgsource
    }

    PetStage {
        anchors.fill: parent
        characterSize: root.characterSize
        characterSource: touchAnimation.imgsource
        onPetTapped: touchAnimation.restart()
    }
}
