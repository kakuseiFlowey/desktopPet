import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import "components"
import "modes/everyday"
import "modes/walk"
import "services/DateService.js" as DateService

ApplicationWindow {
    id: window

    width: 460
    height: 680
    minimumWidth: 320
    minimumHeight: 500
    visible: true
    title: qsTr("ウズラと毎日")
    color: "#f7f5ef"

    property date currentDate: new Date()
    property string currentModeId: "everyday"
    readonly property real petCharacterSize: Math.min(
                                                 modeStack.width * 0.76,
                                                 Math.max(170, window.height * 0.5 - 80),
                                                 300)

    Timer {
        interval: 60000
        repeat: true
        running: true
        onTriggered: {
            if (DateService.keyForDate(window.currentDate) !== DateService.keyForDate(new Date()))
                window.currentDate = new Date()
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
                text: qsTr("きょうのウズラ")
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

        ModeSelector {
            Layout.fillWidth: true
            currentModeId: window.currentModeId
            onModeSelected: function(modeId) {
                window.currentModeId = modeId
            }
        }

        StackLayout {
            id: modeStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: window.currentModeId === "walk" ? 1 : 0

            EverydayMode {
                currentDate: window.currentDate
                active: window.currentModeId === "everyday"
                maximumDialogueHeight: Math.max(60, Math.min(130, 60 + (window.height - 500) * 0.39))
                characterSize: window.petCharacterSize
            }

            WalkMode {
                active: window.currentModeId === "walk"
                maximumDialogueHeight: Math.max(60, Math.min(130, 60 + (window.height - 500) * 0.39))
                characterSize: window.petCharacterSize
            }
        }
    }
}
