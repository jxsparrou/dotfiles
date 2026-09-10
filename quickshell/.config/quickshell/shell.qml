import QtQuick
import Quickshell

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"

        Text {
            anchors.centerIn: parent

            text: "John's Quickshell"
            color: "#ffffff"
            font.pixelSize: 14
        }
    }
}
