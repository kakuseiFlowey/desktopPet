import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property var content: ({})
    property int dialogueIndex: 0
    property real maximumDialogueHeight: 100

    spacing: 10

    SpeechBubble {
        Layout.fillWidth: true
        maximumTextHeight: root.maximumDialogueHeight
        text: root.content.dialogue && root.content.dialogue.length > root.dialogueIndex
              ? root.content.dialogue[root.dialogueIndex].text : ""
    }
}
