import QtQuick
import QtQuick.Layouts
import "../../components"
import "../../services/DateService.js" as DateService
import "../../content/AnniversaryProvider.js" as AnniversaryProvider
import "../../content/ContentProvider.js" as ContentProvider
import "../../content/data/anniversaries.js" as AnniversaryData

Item {
    id: root

    property date currentDate: new Date()
    property bool active: false
    property real maximumDialogueHeight: 100
    property var todayContent: ({})
    property int dialogueIndex: 0

    function refreshContent() {
        todayContent = AnniversaryProvider.createContent(
                    currentDate,
                    DateService.keyForDate(currentDate),
                    AnniversaryData.entries,
                    ContentProvider.createContent)
        dialogueIndex = 0
        if (active)
            petCharacter.startTalking()
    }

    function advanceDialogue() {
        if (!todayContent.dialogue || todayContent.dialogue.length === 0)
            return
        dialogueIndex = (dialogueIndex + 1) % todayContent.dialogue.length
        petCharacter.startTalking()
    }

    onCurrentDateChanged: refreshContent()
    onActiveChanged: {
        if (!active)
            petCharacter.stopTalking()
    }
    Component.onCompleted: refreshContent()

    ColumnLayout {
        anchors.fill: parent
        spacing: 14

        ContentView {
            Layout.fillWidth: true
            content: root.todayContent
            dialogueIndex: root.dialogueIndex
            maximumDialogueHeight: root.maximumDialogueHeight
        }

        PetCharacter {
            id: petCharacter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 180
            characterSize: Math.min(width * 0.76, Math.max(170, root.height * 0.5 - 80), 300)
        }

        PrimaryActionButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Math.min(240, root.width - 48)
            Layout.preferredHeight: 48
            text: qsTr("つづきを聞く")
            enabled: !!root.todayContent.dialogue && root.todayContent.dialogue.length > 1
            onClicked: root.advanceDialogue()
        }
    }
}
