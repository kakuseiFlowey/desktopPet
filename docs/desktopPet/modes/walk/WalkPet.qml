import QtQuick
import "../../components"

Item {
    id: root

    property bool active: false
    property bool stepping: false
    property real characterSize: 220
    readonly property bool touchAnimationActive: touchAnimation.animationRunning

    Timer {
        interval: 500
        repeat: true
        running: root.active
        onTriggered: root.stepping = !root.stepping
    }

    onActiveChanged: {
        if (!active)
            stepping = false
    }

    TouchAnimation {
        id: touchAnimation
        active: root.active
        baseSource: root.stepping
                    ? Qt.resolvedUrl("../../assets/step.png")
                    : Qt.resolvedUrl("../../assets/quail.png")
    }

    PetStage {
        anchors.fill: parent
        characterSize: root.characterSize
        characterSource: touchAnimation.imgsource
        onPetTapped: touchAnimation.restart()
    }
}
