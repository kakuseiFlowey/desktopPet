import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import "components"
import "services/DateService.js" as DateService
import "content/AnniversaryProvider.js" as AnniversaryProvider
import "content/ContentProvider.js" as ContentProvider
import "content/data/anniversaries.js" as AnniversaryData

ApplicationWindow {
    id: window

    width: 460
    height: 680
    minimumWidth: 320
    minimumHeight: 500
    visible: true
    title: qsTr("ことりと毎日")
    color: "#f7f5ef"

    property date currentDate: new Date()
    property var todayContent: ({})
    property int dialogueIndex: 0

    function refreshContent() {
        currentDate = new Date()
        todayContent = AnniversaryProvider.createContent(
                    currentDate,
                    DateService.keyForDate(currentDate),
                    AnniversaryData.entries,
                    ContentProvider.createContent)
        dialogueIndex = 0
        petCharacter.startTalking()
    }

    function advanceDialogue() {
        if (!todayContent.dialogue || todayContent.dialogue.length === 0)
            return
        dialogueIndex = (dialogueIndex + 1) % todayContent.dialogue.length
        petCharacter.startTalking()
    }

    Component.onCompleted: refreshContent()

    Timer {
        interval: 60000
        repeat: true
        running: true
        onTriggered: {
            if (DateService.keyForDate(window.currentDate) !== DateService.keyForDate(new Date()))
                window.refreshContent()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Math.max(18, Math.min(30, window.width * 0.06))
        spacing: 14

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Rectangle {
                implicitWidth: 9
                implicitHeight: 9
                radius: 5
                color: "#76a994"
            }

            Label {
                text: qsTr("きょうのことり")
                color: "#48675b"
                font.pixelSize: 13
                font.weight: Font.DemiBold
            }

            Item { Layout.fillWidth: true }

            Label {
                text: DateService.formatJapaneseDate(window.currentDate)
                color: "#807e75"
                font.pixelSize: 13
            }
        }

        ContentView {
            Layout.fillWidth: true
            content: window.todayContent
            dialogueIndex: window.dialogueIndex
        }

        PetCharacter {
            id: petCharacter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 180
        }

        Button {
            id: nextButton
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Math.min(240, window.width - 48)
            Layout.preferredHeight: 48
            text: qsTr("つづきを聞く")
            enabled: !!window.todayContent.dialogue && window.todayContent.dialogue.length > 1

            contentItem: Label {
                text: nextButton.text
                color: nextButton.enabled ? "#ffffff" : "#b8c5bd"
                font.pixelSize: 15
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                radius: 18
                color: nextButton.enabled ? "#719b86" : "#e4e8e3"
                Behavior on color { ColorAnimation { duration: 160 } }
            }

            onClicked: window.advanceDialogue()
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("また明日もお話ししようね")
            color: "#a09d91"
            font.pixelSize: 11
        }
    }
}
