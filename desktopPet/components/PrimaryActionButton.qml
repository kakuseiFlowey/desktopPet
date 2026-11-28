import QtQuick
import QtQuick.Controls.Basic

Button {
    id: root

    implicitWidth: 240
    implicitHeight: 48

    contentItem: Label {
        text: root.text
        color: root.enabled ? "#ffffff" : "#b8c5bd"
        font.pixelSize: 15
        font.weight: Font.DemiBold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        radius: 18
        color: root.enabled ? "#719b86" : "#e4e8e3"
        Behavior on color { ColorAnimation { duration: 160 } }
    }
}
