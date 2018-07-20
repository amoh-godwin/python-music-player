import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "musicCustoms"

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600

    title: qsTr(' ')

    MusicProperties {id: music_settings}

    property bool inPotrait: window.width < 1024
    property color artistNeutral: Qt.darker("#D13438")
    property color artistTint: Qt.tint(artistNeutral, "#21ffffff")
    property var songs_list: []
    property int songs_count: 0

    // Drawer and the stack
    Rectangle {

        width: parent.width
        height: parent.height

        Drawer {
            id: navCont
            width: 320
            height: parent.height - 90
            visible: !inPotrait
            interactive: false
            modal: false

            background: Rectangle {
                color: "#f1f1f1"
            }

            CustomDrawerToolBar {}

        }

        StackView {

            id: stack
            x: !inPotrait && navCont.position == 0 ? sideNav.width : 0
            width: !inPotrait && navCont.position > 0 ? parent.width - (320 * navCont.position) : parent.width - sideNav.width
            height: parent.height - 90
            transform: Translate {
                x: inPotrait ? sideNav.width : navCont.position * 320
            }
            initialItem: sv
            focus: true

            Component {

                id: sv

                Rectangle {
                    width: stack.width
                    height: stack.height
                    color: "transparent"

                    ScrollView {

                        id: sv1
                        width: stack.width
                        height: parent.height
                        clip: true
                        focus: true

                        ListView {
                            id: songs_view
                            anchors {
                                right: parent.right
                                rightMargin: 24
                                left: parent.left
                                leftMargin: 24
                                top: parent.top
                                topMargin: mainNav.height
                                bottom: parent.bottom
                            }

                            model: MusicModel {}

                            delegate: MusicDelegate {}

                            Component.onCompleted: {
                                model.append(songs_list)
                                songs_count = songs_view.count
                            }

                            focus: true

                        }

                    }

                }

            }

        }

    }

    // The Navs
    Rectangle {
        anchors.fill: parent
        color: "transparent"

        CustomSideNav {id: sideNav}


        Rectangle {
            id: mainNav
            anchors.right: parent.right
            anchors.rightMargin: 24
            width: parent.width - sideNav.width - (24 * 2)
            height: 248
            color: "white"

            ColumnLayout {
                width: parent.width
                spacing: 0

                Text {
                    topPadding: 8
                    bottomPadding: 8
                    text: qsTr('My music')
                    font.family: "Segoe UI Light"
                    font.pixelSize: 36
                }

                TabBar {

                    //Layout.fillWidth: true
                    spacing: 24

                    background: Rectangle {
                        implicitWidth: 20
                        implicitHeight: 40

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.parent.parent.parent.width
                            height: 1
                            color: "#45777777"
                        }

                    }

                    CustomTabButton {
                        text: qsTr('Songs')

                    }

                    CustomTabButton {
                        text: qsTr('Artists')

                    }

                    CustomTabButton {
                        text: qsTr('Albums')

                    }


                }

                ToolBar {
                    Layout.fillWidth: true
                    height: 64

                    background: Rectangle {
                        implicitHeight: 64
                        implicitWidth: 100
                        color: "transparent"

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: "#45777777"
                        }
                    }

                    RowLayout {
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        //anchors.verticalCenter: parent.verticalCenter
                        height: 48

                        CustomShuffleButton {
                            Layout.fillHeight: true
                            text: qsTr('Shuffle all (' + songs_count + ')')
                            unicon: "\uE8b1"
                        }


                        CustomShuffleButton {
                            Layout.fillHeight: true
                            text: qsTr('Sort by:')
                            secText: qsTr('Date added')
                        }

                        CustomShuffleButton {
                            Layout.fillHeight: true
                            text: qsTr('Filter:')
                            secText: qsTr('All')
                        }

                        CustomShuffleButton {
                            Layout.fillHeight: true
                            text: qsTr('Genre:')
                            secText: qsTr('All genres')
                        }

                    }


                }

                ToolBar {
                    Layout.fillWidth: true
                    height: 64

                    background: Rectangle {
                        implicitHeight: 64
                        implicitWidth: 100
                        color: "transparent"

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: "#45777777"
                        }
                    }

                    RowLayout {
                        width: parent.width
                        height: parent.height

                        ColumnLayout {
                            Layout.fillWidth: true

                            RowLayout {
                                spacing: 8

                                Text {
                                    text: "\uE8b7"
                                    font.family: "Segoe MDL2 Assets"
                                    font.pixelSize: 14
                                }

                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: "Not finding everything?"
                                    font.family: "Segoe UI Semilight"
                                    font.pixelSize: 13
                                }

                            }

                            Text {
                                leftPadding: 22
                                text: "Show us where to look for music"
                                font.family: "Segoe UI Semilight"
                                font.pixelSize: 13
                                color: "#298FCC"
                            }

                        }

                        CustomShuffleButton {
                            anchors.right: parent.right
                            unicon: "\uE8bb"
                            uniconSize: 10
                        }

                    }


                }

            }
        }


        Rectangle {
            id: playCont
            width: parent.width
            height: 90
            anchors.bottom: parent.bottom
            color: artistTint

            RowLayout {
                width: parent.width
                height: parent.height
                spacing: 20

                // Album Art
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: playCont.width / 3
                    //Layout.maximumWidth: 368
                    color: artistNeutral

                    RowLayout {
                        width: parent.width
                        height: parent.height

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "#e1e1e1"

                            Text {
                                anchors.centerIn: parent
                                text: music_settings.albumIcon
                                font.family: "Segoe MDL2 Assets"
                                font.pixelSize: 32
                            }

                        }

                        Column {
                            width: parent.parent.width - 90 - parent.spacing
                            Text {
                                width: parent.parent.parent.width - 90 - parent.parent.spacing - 10
                                text: qsTr('River Of Jordan || Busysinging.com')
                                font.family: "Segoe UI Light"
                                color: "white"
                                font.pixelSize: 20
                                font.bold: false
                                font.weight: Font.Thin

                                clip: true
                            }

                            Text {
                                width: parent.children[0].width
                                text: qsTr('Lecrae')
                                font.family: "Segoe UI"
                                font.pixelSize: 16
                                font.bold: true
                                color: "white"
                                clip: true
                            }
                        }

                    }

                }

                // Play Controls
                ColumnLayout {
                    width: playCont.width / 3 || 250
                    Layout.fillHeight: true
                    spacing: 0

                    RowLayout {
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: 50

                        CustomPlayButton {
                            anchors.verticalCenter: parent.verticalCenter
                            text: music_settings.shuffleIcon
                            visible: !inPotrait
                        }

                        CustomPlayButton {
                            anchors.verticalCenter: parent.verticalCenter
                            text: music_settings.previousIcon
                        }

                        Button {
                            anchors.verticalCenter: parent.verticalCenter
                            text: music_settings.playIcon

                            background: Rectangle {
                                implicitWidth: 48
                                implicitHeight: 48
                                radius: 24
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                                border.width: 2
                                border.color: parent.hovered || parent.pressed ? "#25000000" : "#25ffffff"
                            }

                            contentItem: Text{
                                text: parent.text
                                font.family: music_settings.segoeIcons.family
                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                color: "white"
                            }

                        }

                        CustomPlayButton {
                            anchors.verticalCenter: parent.verticalCenter
                            text: music_settings.nextIcon

                        }

                        CustomPlayButton {
                            anchors.verticalCenter: parent.verticalCenter
                            text: music_settings.repeatOne
                            visible: !inPotrait
                        }

                    }

                    RowLayout {
                        Layout.fillWidth: true
                        height: 40

                        Text {
                            text: qsTr('1:18')
                            color: "white"
                        }

                        CustomSlider {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: qsTr('1:18')
                            color: "white"
                        }

                    }

                }

                // Other Controls
                RowLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: playCont.width / 3

                    Row {
                        anchors.right: parent.right
                        anchors.rightMargin: 8

                        CustomPlayButton {
                            text: music_settings.volume3Icon
                        }

                        CustomSlider {
                            //
                        }

                        CustomPlayButton {

                            text: music_settings.moreIcon

                            onClicked: {
                                contextMenu.popup()
                            }
                        }

                        // popup Menu Does not draw unless it's called
                        CustomMenu {
                            id: contextMenu

                            Action {
                                text: qsTr('Shuffle: off')
                                icon.name: music_settings.shuffleIcon
                            }

                            Action {
                                text: qsTr('Repeat: One')
                                icon.name: music_settings.repeatOne
                            }

                            Action {
                                text: qsTr('Switch to Fullscreen')
                                icon.name: music_settings.fullscreenIcon
                            }

                        }

                    }

                }

            }

        }

    }
}
