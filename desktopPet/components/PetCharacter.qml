import QtQuick

Item {
    id: root

    property string mood: "idle"
    property real characterSize: 220

    function startTalking() {
        mood = "talking"
        sourceAnimation.startTalkingAnimation()
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

    SourceAnimation {
        id: sourceAnimation
        mood: root.mood
        onTalkingFinished: root.mood = "idle"
    }

    Image {
        id: petImage
        source: sourceAnimation.imgsource
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: platform.top
        width: Math.min(root.characterSize, parent.width * 0.76)
        height: width
        fillMode: Image.PreserveAspectFit
        smooth: true
        transformOrigin: Item.Bottom
    }

}
