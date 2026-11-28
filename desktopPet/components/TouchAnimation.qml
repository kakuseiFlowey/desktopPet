import QtQuick

Item {
    id: root

    property bool active: false
    property bool animationRunning: false
    property bool showingWatch: false
    property url baseSource: Qt.resolvedUrl("../assets/quail.png")
    property url imgsource: animationRunning
                             ? (showingWatch ? Qt.resolvedUrl("../assets/watch.png")
                                             : Qt.resolvedUrl("../assets/quail.png"))
                             : baseSource

    function restart() {
        if (!active)
            return

        showingWatch = true
        animationRunning = true
        frameTimer.restart()
        durationTimer.restart()
    }

    function stop() {
        animationRunning = false
        showingWatch = false
        frameTimer.stop()
        durationTimer.stop()
    }

    onActiveChanged: {
        if (!active)
            stop()
    }

    Timer {
        id: frameTimer
        interval: 800
        repeat: true
        running: root.active && root.animationRunning
        onTriggered: root.showingWatch = !root.showingWatch
    }

    Timer {
        id: durationTimer
        interval: 4000
        onTriggered: root.stop()
    }
}
