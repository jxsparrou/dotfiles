//@ pragma UseQApplication

import QtQuick
import Quickshell
import "Bar" // this is where the Bar logic should be held. it is a directory

ShellRoot{
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            id: barWindow
            screen: modelData

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

                    //Left Side -
                    Workspaces {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        screen: barWindow.screen
                    }

                    // Center
                    Clock {
                        anchors.centerIn: parent
                    }

                    // Right Side
                    Row {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8

                        Network {
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Volume {
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        SysTray {
                            anchors.verticalCenter: parent.verticalCenter
                            window: barWindow
                        }
                    }
                }
            }
        }
    }
}
