pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

RowLayout {
    id: root

    property string currentModeId: "everyday"
    property var modes: [
        { id: "everyday", label: qsTr("何の日") },
        { id: "walk", label: qsTr("お散歩") }
    ]

    signal modeSelected(string modeId)

    spacing: 4

    Repeater {
        model: root.modes

        delegate: Button {
            id: modeButton
            required property var modelData

            Layout.fillWidth: true
            Layout.preferredHeight: 42
            text: modelData.label
            checkable: true
            checked: root.currentModeId === modelData.id
            onClicked: root.modeSelected(modelData.id)

            contentItem: Label {
                text: modeButton.text
                color: modeButton.checked ? "#ffffff" : "#59665e"
                font.pixelSize: 13
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                radius: 14
                color: modeButton.checked ? "#719b86" : "#eeefe9"
                border.color: modeButton.checked ? "#719b86" : "#e5e8df"
                Behavior on color { ColorAnimation { duration: 160 } }
            }
        }
    }
}
