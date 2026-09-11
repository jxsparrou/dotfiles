import QtQuick
import Quickshell.Services.Pipewire

Text {
    color: "#ffffff"
    font.pixelSize: 12

    property var sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [sink]
    }

    text: sink?.audio
    ? (sink.audio.muted
        ? "Muted"
        : Math.round(sink.audio.volume * 100) + "%")
    : "--"

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (sink?.audio)
                sink.audio.muted = !sink.audio.muted
        }

        onWheel: wheel => {
            if (!sink?.audio)
                return

            const step = 0.05

            if (wheel.angleDelta.y > 0)
                sink.audio.volume = Math.min(1.0, sink.audio.volume + step)
            else if (wheel.angleDelta.y < 0)
                sink.audio.volume = Math.max(0.0, sink.audio.volume - step)
        }
    }
}
