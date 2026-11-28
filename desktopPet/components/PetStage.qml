import QtQuick

Item {
    id: root

    property url characterSource: Qt.resolvedUrl("../assets/quail.png")
    property real characterSize: 220

    signal petTapped

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
        source: root.characterSource
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: platform.top
        width: Math.min(root.characterSize, parent.width * 0.76)
        height: width
        fillMode: Image.PreserveAspectFit
        smooth: true
        mirror: true
        transformOrigin: Item.Bottom

        TapHandler {
            onTapped: root.petTapped()
        }
    }
}
