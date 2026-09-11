//@ pragma UseQApplication

import QtQuick
import Quickshell
import "Bar" // this is where the Bar logic should be held


PanelWindow {
    id: barWindow

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"

        Item {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12

            //Left Side
            Workspaces {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            // Center
            Clock {
                anchors.centerIn: parent
            }

            // Right Side
            SysTray {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                window: barWindow
            }
        }
    }
}
