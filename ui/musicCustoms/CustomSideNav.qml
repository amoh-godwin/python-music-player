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
        buttons: btnConts.children
        exclusive: true

        onClicked: {
            button.checked = true
        }
    }

    ColumnLayout {
        id: btnConts
        width: parent.width
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
            text: "\uE721"
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: "\uEc4f"
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: "\uE823"
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: "\uE700"
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: "\uE90B"
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: "\uE710"
        }

        CustomToolButton {
            Layout.fillWidth: true
            text: "\uE712"
        }
    }

}
