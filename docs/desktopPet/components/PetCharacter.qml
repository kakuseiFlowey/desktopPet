import QtQuick

Item {
    id: root

    property string mood: "idle"
    property bool active: false
    property real characterSize: 220

    function startTalking() {
        touchAnimation.stop()
        mood = "talking"
        sourceAnimation.startTalkingAnimation()
    }

    function stopTalking() {
        mood = "idle"
    }

    function startTouchAnimation() {
        stopTalking()
        touchAnimation.restart()
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
        onPetTapped: root.startTouchAnimation()
    }
}
