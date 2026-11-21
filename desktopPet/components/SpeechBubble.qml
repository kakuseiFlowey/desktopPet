import QtQuick
import QtQuick.Controls.Basic

Item {
    id: root

    property string text: ""
    property string speaker: qsTr("ことり")

    implicitHeight: bubble.implicitHeight + 14
    implicitWidth: 280

    Rectangle {
        id: bubble
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        implicitHeight: bubbleColumn.implicitHeight + 28
        radius: 20
        color: "#ffffff"
        border.color: "#e9e6db"
        border.width: 1

        Column {
            id: bubbleColumn
            anchors.fill: parent
            anchors.margins: 16
            spacing: 7

            Label {
                text: root.speaker
                color: "#719b86"
                font.pixelSize: 12
                font.weight: Font.DemiBold
            }

            Label {
                id: dialogueText
                width: bubbleColumn.width
                text: root.text
                color: "#393b36"
                font.pixelSize: 16
                lineHeight: 1.35
                wrapMode: Text.Wrap
            }
        }

        Rectangle {
            width: 15
            height: 15
            color: bubble.color
            border.color: bubble.border.color
            rotation: 45
            anchors.horizontalCenter: bubble.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -7
            z: -1
        }
    }

    SequentialAnimation {
        id: textChangeAnimation
        NumberAnimation { target: dialogueText; property: "opacity"; to: 0.25; duration: 90 }
        NumberAnimation { target: dialogueText; property: "opacity"; to: 1; duration: 180 }
    }

    onTextChanged: textChangeAnimation.restart()
}
