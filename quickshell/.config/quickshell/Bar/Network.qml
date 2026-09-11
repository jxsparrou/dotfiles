import QtQuick
import Quickshell.Networking

Text {
    color: "#ffffff"
    font.pixelSize: 12

    property var connectedDevices: Networking.devices.values.filter(
        device => device.connected
    )

    text: {
        const active = Networking.devices.values.find(
            device => device.connected
        )

        if (!active)
            return "Disconnected"

            return active.type === 2
                ? "Ethernet"
                : active.network?.name ?? "Wi-Fi"
    }
}
