import QtQuick 2.10
import QtQuick.Controls 2.3

Button {
    id: ctrl

    MusicProperties { id: music_settings}

    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: 20
        color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
    }

    contentItem: Text{
        text: ctrl.text
        font: music_settings.segoeIcons
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "white"
    }

}
