import QtQuick

Item {
    id: root

    property string mood: "idle"
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

    PetStage {
        anchors.fill: parent
        characterSize: root.characterSize
        characterSource: sourceAnimation.imgsource
    }
}
