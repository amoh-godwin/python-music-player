import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "musicCustoms"

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    font.family: "Segoe UI"

    title: qsTr(' ')


    property bool inPotrait: window.width < 1024
    property color artistNeutral: Qt.darker("#D13438")
    property color artistTint: Qt.tint(artistNeutral, "#21ffffff")
    property var songs: {"song": "Song Title", "artist": "Artist Name", "time": "12: 03"}

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

            ToolBar {
                id: drawerNav
                anchors.left: parent.left
                width: parent.width
                height: parent.height - 90
                spacing: 0

                background: Rectangle {
                    color: "#f1f1f1"

                }

                ColumnLayout {
                    width: parent.width
                    spacing: 0

                    CustomToolButton {
                        Layout.preferredWidth: 48
                        iconSource: "icons/ic_menu_black_24dp.png"

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
                                color: if(parent.activeFocus) {
                                           "white"
                                       }else if(parent.hovered) {
                                           Qt.rgba(255, 255, 255, 0.75)
                                       }else {
                                           "#75ffffff"
                                       }

                                Row {
                                    id: rw
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter

                                    CustomButton {
                                        icon.source: "icons/ic_close_black_48dp.png"
                                        visible: sch_field.length > 0
                                        onClicked: sch_field.text = ""
                                    }

                                    CustomButton {
                                        icon.source: "icons/ic_search_black_48dp.png"
                                    }

                                }
                            }

                        }
                    }

                    CustomDrawerButton {
                        Layout.fillWidth: true
                        text: qsTr("My music")
                        icon.source: "icons/ic_queue_music_black_48dp.png"
                    }

                    CustomDrawerButton {
                        Layout.fillWidth: true
                        text: qsTr("Recent Plays")
                        icon.source: "icons/ic_query_builder_black_48dp.png"
                    }

                    CustomDrawerButton {
                        Layout.fillWidth: true
                        text: qsTr("Now playing")
                        icon.source: "icons/ic_equalizer_black_48dp.png"
                    }

                    ToolSeparator {
                        anchors.horizontalCenter: parent.horizontalCenter
                        Layout.preferredWidth: 300
                        orientation: Qt.Horizontal
                    }

                    CustomDrawerButton {
                        Layout.fillWidth: true
                        text: qsTr('Playlists')
                        icon.source: "icons/ic_playlist_play_black_48dp.png"
                    }
                }

            }

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

                            model: 40

                            delegate: MusicDelegate {}

                            focus: true

                        }

                    }

                }

            }

        }

    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        ToolBar {
            id: sideNav
            anchors.left: parent.left
            width: 48
            height: parent.height - 90
            spacing: 0

            background: Rectangle {
                color: "#f1f1f1"
            }

            ColumnLayout {
                width: parent.width
                spacing: 0

                CustomToolButton {
                    Layout.fillWidth: true
                    text: "\uE700"

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
                            text: qsTr('Shuffle all (98)')
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

                        Image {
                            Layout.fillHeight: true
                            //height: 90
                            sourceSize.width: 90
                            //sourceSize.height: 120
                            //fillMode: Image.PreserveAspectCrop
                            source: "images/apple-3341245_1920.jpg"
                            clip: true
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

                        Button {
                            anchors.verticalCenter: parent.verticalCenter
                            icon.source: "icons/ic_shuffle_black_48dp.png"
                            icon.color: "white"

                            background: Rectangle {
                                implicitWidth: 40
                                implicitHeight: 40
                                radius: 20
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                            }
                            visible: !inPotrait
                        }

                        Button {
                            anchors.verticalCenter: parent.verticalCenter
                            icon.source: "icons/ic_skip_previous_black_48dp.png"
                            icon.color: "white"

                            background: Rectangle {
                                implicitWidth: 40
                                implicitHeight: 40
                                radius: 20
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                            }
                        }

                        Button {
                            anchors.verticalCenter: parent.verticalCenter
                            icon.source: "icons/ic_pause_black_48dp.png"
                            icon.color: "white"

                            background: Rectangle {
                                implicitWidth: 48
                                implicitHeight: 48
                                radius: 24
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                                border.width: 2
                                border.color: parent.hovered || parent.pressed ? "#25000000" : "#25ffffff"
                            }

                        }

                        Button {
                            anchors.verticalCenter: parent.verticalCenter
                            icon.source: "icons/ic_skip_next_black_48dp.png"
                            icon.color: "white"

                            background: Rectangle {
                                implicitWidth: 40
                                implicitHeight: 40
                                radius: 20
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                            }

                        }

                        Button {
                            anchors.verticalCenter: parent.verticalCenter
                            icon.source: "icons/ic_replay_black_48dp.png"
                            icon.color: "white"

                            background: Rectangle {
                                implicitWidth: 40
                                implicitHeight: 40
                                radius: 20
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                            }
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

                        Button {
                            icon.source: "icons/ic_volume_up_black_48dp.png"
                            icon.color: "white"

                            background: Rectangle {
                                implicitWidth: 40
                                implicitHeight: 40
                                radius: 20
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                            }
                        }

                        CustomSlider {
                            //
                        }

                        Button {
                            icon.source: "icons/ic_more_horiz_black_48dp.png"
                            icon.color: "white"

                            background: Rectangle {
                                implicitWidth: 40
                                implicitHeight: 40
                                radius: 20
                                color: parent.hovered || parent.pressed ? "#25000000" : "transparent"
                            }
                        }

                    }

                }

            }

        }

    }
}
