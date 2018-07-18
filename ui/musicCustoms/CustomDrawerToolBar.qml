import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ToolBar {
    id: drawerNav
    anchors.left: parent.left
    width: parent.width
    height: parent.height
    spacing: 0

    background: Rectangle {
        color: "#f1f1f1"

    }

    ColumnLayout {
        width: parent.width
        height: parent.height
        spacing: 0

        CustomToolButton {
            Layout.preferredWidth: 48
            text: music_settings.navIcon

            onClicked: navCont.close()

        }

        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: "transparent"

            TextField {
                id: sch_field
                anchors.centerIn: parent
                placeholderText: qsTr("Search")

                font.pixelSize: 16
                font.family: "Segoe UI"
                rightPadding: rw.width

                background: Rectangle {
                    implicitWidth: 300
                    implicitHeight: 36
                    color: parent.activeFocus ? "white" :
                                                (parent.hovered ? Qt.rgba(255, 255, 255, 0.75) :
                                                                  "#75ffffff")

                    Row {
                        id: rw
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        CustomButton {
                            text: music_settings.cancelIcon
                            visible: sch_field.length > 0
                            onClicked: sch_field.text = ""
                        }

                        CustomButton {
                            text: music_settings.searchIcon
                        }

                    }
                }

            }
        }

        CustomDrawerButton {
            Layout.fillWidth: true
            text: qsTr("My music")
            unicode: music_settings.musicIcon
        }

        CustomDrawerButton {
            Layout.fillWidth: true
            text: qsTr("Recent Plays")
            unicode: music_settings.recentIcon
        }

        CustomDrawerButton {
            Layout.fillWidth: true
            unicode: music_settings.nowPlayingIcon
            text: qsTr("Now playing")
        }

        ToolSeparator {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 0
            bottomPadding: 0
            Layout.preferredWidth: 300
            orientation: Qt.Horizontal
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            height: 48

            CustomDrawerButton {
                Layout.fillWidth: true
                text: qsTr('Playlists')
                unicode: music_settings.playlistIcon
            }

            CustomToolButton {
                Layout.preferredWidth: 48
                Layout.preferredHeight: 48
                text: music_settings.addIcon
            }

        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            ColumnLayout {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                width: parent.width
                spacing: 0

                ToolSeparator {
                    bottomPadding: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredWidth: 300
                    orientation: Qt.Horizontal
                }

                CustomDrawerButton {
                    Layout.fillWidth: true
                    text: qsTr('Settings')
                    unicode: music_settings.cogIcon
                }

            }

        }

    }

}
