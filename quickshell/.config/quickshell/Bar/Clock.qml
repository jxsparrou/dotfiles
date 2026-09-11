import QtQuick
import Quickshell

Text {
    color: "#ffffff"
    font.pixelSize: 14

    text: Qt.formatDateTime(clock.date, "h:mm AP")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
