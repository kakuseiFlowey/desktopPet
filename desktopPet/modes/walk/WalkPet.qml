import QtQuick
import "../../components"

Item {
    id: root

    property bool active: false
    property bool stepping: false
    property real characterSize: 220

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

    PetStage {
        anchors.fill: parent
        characterSize: root.characterSize
        characterSource: root.stepping
                         ? Qt.resolvedUrl("../../assets/step.png")
                         : Qt.resolvedUrl("../../assets/quail.png")
    }
}
