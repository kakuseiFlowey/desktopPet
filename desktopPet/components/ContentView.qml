import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ColumnLayout {
    id: root

    property var content: ({})
    property int dialogueIndex: 0

    spacing: 10

    RowLayout {
        Layout.fillWidth: true

        Label {
            text: root.content.title || qsTr("今日は何の日？")
            color: "#343a35"
            font.pixelSize: 21
            font.weight: Font.Bold
            elide: Text.ElideRight
            Layout.fillWidth: true
        }

        Label {
            text: root.content.category === "anniversary" ? qsTr("記念日") : qsTr("きょう")
            color: "#719b86"
            font.pixelSize: 11
            font.weight: Font.DemiBold
            padding: 7
            background: Rectangle {
                radius: 10
                color: "#e9f0e9"
            }
        }
    }

    SpeechBubble {
        Layout.fillWidth: true
        text: root.content.dialogue && root.content.dialogue.length > root.dialogueIndex
              ? root.content.dialogue[root.dialogueIndex].text : ""
    }
}
