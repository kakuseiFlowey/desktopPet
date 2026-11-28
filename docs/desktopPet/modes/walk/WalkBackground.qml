import QtQuick

Item {
    id: root

    property bool active: false
    property bool touchAnimationActive: false
    property real imageWidth: Math.max(
                                  width,
                                  height * firstImage.sourceSize.width
                                  / Math.max(1, firstImage.sourceSize.height))
    property real scrollProgress: 0
    readonly property real imageOffset: scrollProgress * imageWidth

    clip: true

    Image {
        id: firstImage
        source: Qt.resolvedUrl("../../assets/walk_background.png")
        x: root.imageOffset - root.imageWidth
        width: root.imageWidth
        height: root.height
        fillMode: Image.Stretch
        smooth: true
    }

    Image {
        source: Qt.resolvedUrl("../../assets/walk_background.png")
        x: root.imageOffset
        width: root.imageWidth
        height: root.height
        fillMode: Image.Stretch
        smooth: true
    }

    NumberAnimation {
        target: root
        property: "scrollProgress"
        from: 0
        to: 1
        duration: 120000
        loops: Animation.Infinite
        running: root.active
        paused: root.touchAnimationActive
    }

}
