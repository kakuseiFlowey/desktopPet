import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ColumnLayout {
    id: root

    property var content: ({})
    property int dialogueIndex: 0

    spacing: 10

    SpeechBubble {
        Layout.fillWidth: true
        text: root.content.dialogue && root.content.dialogue.length > root.dialogueIndex
              ? root.content.dialogue[root.dialogueIndex].text : ""
    }
}
