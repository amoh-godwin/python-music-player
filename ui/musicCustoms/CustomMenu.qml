import QtQuick 2.10
import QtQuick.Controls 2.3

Menu {

    MusicProperties { id: music_settings}

    delegate: MenuItem {
        id: menuItem
        implicitWidth: 200
        implicitHeight: 40

        indicator: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            color: "transparent"

            Text {
                font: music_settings.segoeIcons
                anchors.centerIn: parent
                text: menuItem.icon.name
            }
        }

        contentItem: Text {
            leftPadding: parent.indicator.width
            text: menuItem.text
            font: music_settings.segoeLight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }

        background: Rectangle {
            //implicitWidth: 200
            //implicitHeight: 40
            color: menuItem.highlighted ? "#e1e1e1" : "transparent"
        }

    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        color: "#f1f1f1"
        border.color: "#e1e1e1"
    }

}
