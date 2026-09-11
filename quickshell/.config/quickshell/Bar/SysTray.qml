import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

RowLayout{
    property var window

    spacing: 6

    Repeater {
        model: SystemTray.items

        delegate: Item {
            required property var modelData

            implicitHeight: 24
            implicitWidth: 24

            Image {
                anchors.centerIn: parent

                width: 18
                height: 18

                source: modelData.icon
                sourceSize.width: 18
                sourceSize.height: 18

                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton


                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        modelData.activate()
                    }

                    if (mouse.button === Qt.RightButton && modelData.hasMenu) {
                        modelData.display(
                            window,
                            mouse.x,
                            mouse.y
                        )
                    }
                }
            }
        }
    }
}
