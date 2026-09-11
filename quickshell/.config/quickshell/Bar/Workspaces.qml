import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    property var screen
    property var hyprMonitor: Hyprland.monitorFor(screen)

    Repeater {
        model: Hyprland.workspaces.values.filter(
            workspace => workspace.monitor === hyprMonitor
        )

        delegate: Rectangle {
            required property var modelData

            implicitWidth: 28
            implicitHeight: 24
            radius: 6

            color: modelData === Hyprland.focusedWorkspace
            ? "#585b70"
            : "$313244"

            Text {
                anchors.centerIn: parent
                text: modelData.name
                color: "#ffffff"
                font.pixelSize: 12
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    modelData.activate()
                }
            }
        }
    }
}
