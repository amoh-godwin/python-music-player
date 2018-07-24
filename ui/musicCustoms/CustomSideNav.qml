import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ToolBar {
    id: sideNav
    anchors.left: parent.left
    width: 48
    height: parent.height - 90
    spacing: 0

    background: Rectangle {
        color: "#f1f1f1"
    }

    ButtonGroup {
        id: btn_group
        buttons: btnConts.children
        exclusive: true

        onClicked: {
            button.checked = true
        }
    }

    ColumnLayout {
        id: btnConts
        width: parent.width
        height: parent.height
        spacing: 0

        CustomToolButton {
            Layout.fillWidth: true
            text: music_settings.navIcon

            onClicked: {
                navCont.open()
            }

        }

        CustomToolButton {
            Layout.fillWidth: true
            text: music_settings.searchIcon

            onClicked: {
                navCont.open()
            }

        }

        CustomToolButton {
            Layout.fillWidth: true
            text: music_settings.musicIcon
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: music_settings.recentIcon
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: music_settings.nowPlayingIcon
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: music_settings.playlistIcon
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: music_settings.addIcon
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
        }

        CustomToolButton {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            Layout.fillWidth: true
            text: music_settings.cogIcon
        }

    }

}
