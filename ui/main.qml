import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import "musicCustoms"

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600

    title: qsTr('Python Music')

    MusicProperties {id: music_settings}

    property bool inPotrait: window.width < 1024
    property color artistNeutral: Qt.darker("#D13438")
    property color artistTint: Qt.tint(artistNeutral, "#21ffffff")
    property QtObject song_model: MusicModel {}
    property bool started: false
    property var songs_list: []
    property int songs_count: 0
    property int appendedSongsCount: 0
    property string songs_info_text: "We're adding"
    property string play_var: 'play'
    property string play_text: music_settings.playIcon
    property int now_playing: 0
    property bool paused: false

    signal playFunction()
    signal play()
    signal pause()
    signal stop()
    signal resume()
    signal swapPlayText()
    signal swapPlayFunction(string func_name)

    onPlayFunction: swapPlayFunction(play_var)

    onPlay: {
        stop()
        Functions.play(song_model.get(now_playing).file, song_model.get(now_playing).format_name, song_model.get(now_playing).size)
        play_var = 'pause'
        play_text = music_settings.pauseIcon

    }

    onPause: {
        Functions.pause()
        play_text = music_settings.playIcon
        play_var = 'resume'
    }

    onResume: {
        Functions.resume()
        play_text = music_settings.pauseIcon
        play_var = 'pause'
    }

    onStop: {
        // stop everthing
        Functions.stop()
        play_text = music_settings.playIcon
        play_var = 'play'
    }

    onSwapPlayFunction: {
        if(func_name == 'play') {
            play()
            play_var = 'pause'
        } else if ( func_name == 'pause') {
            pause()
            play_var = 'resume'
        } else {
            resume()
            play_var = 'pause'
        }
    }

    onSwapPlayText: {
        play_text = play_text == music_settings.playIcon ? music_settings.pauseIcon : music_settings.playIcon
    }

    QtObject {
        Component.onCompleted: FileSys.bootUp()
    }

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
            x: !inPotrait && navCont.position === 0 ? sideNav.width : 0
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

                            model: song_model //MusicModel {}

                            delegate: MusicDelegate {}

                            Component.onCompleted: {
                                //FileSys.bootUp()
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

        CustomSideNav { id: sideNav }


        Rectangle {
            id: mainNav
            x: !inPotrait && navCont.position === 0 ? sideNav.width + 24 : 24
            width: !inPotrait && navCont.position > 0 ? parent.width - 48 - (320 * navCont.position) : parent.width - 48 - sideNav.width
            transform: Translate {
                x: inPotrait ? sideNav.width : (navCont.position * 320)
            }
            height: 248
            color: "white"

            ColumnLayout {
                width: parent.width
                spacing: 0


                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 64
                    color: "transparent"

                    RowLayout {
                        width: parent.width
                        height: 64

                        Text {
                            anchors.left: parent.left
                            topPadding: 8
                            bottomPadding: 8
                            text: qsTr('My music')
                            font.family: "Segoe UI Light"
                            font.pixelSize: 36
                        }

                        Rectangle {
                            id: songs_info
                            anchors.top: parent.top
                            anchors.topMargin: 24
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            Layout.preferredWidth: 320
                            Layout.preferredHeight: 48
                            color: "dodgerblue"
                            visible: false

                            RowLayout {
                                anchors.top: parent.top
                                anchors.topMargin: 8
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                width: parent.width - 16
                                height: parent.height - 16

                                ColumnLayout {
                                    anchors.top: parent.top
                                    Layout.fillWidth: true
                                    spacing: 0

                                    Row {
                                        spacing: 8
                                        Text {
                                            text: music_settings.cogIcon
                                            font.family: "Segoe MDL2 Assets"
                                            font.pixelSize: 14
                                            color: "white"
                                        }

                                        Text {
                                            text: songs_info_text + " music"
                                            color: "white"
                                            font.pixelSize: 14
                                        }

                                    }

                                    Text {
                                        text: appendedSongsCount + " songs"
                                        font.pixelSize: 14
                                        color: "white"
                                    }

                                }

                                Text {
                                    anchors.right: parent.right
                                    text: music_settings.cancelIcon
                                    font.family: "Segoe MDL2 Assets"
                                    font.pixelSize: 13
                                    color: "white"
                                }

                            }

                        }

                    }
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
                            id: albumArtCol
                            width: parent.parent.width - 90 - parent.spacing

                            Text {
                                width: parent.parent.parent.width - 90 - parent.parent.spacing - 10
                                text: started ? qsTr(song_model.get(now_playing).title) : ""
                                font.family: "Segoe UI Light"
                                color: "white"
                                font.pixelSize: 20
                                font.bold: false
                                font.weight: Font.Thin
                                clip: true
                            }

                            Text {
                                width: parent.children[0].width
                                text: started ? qsTr(song_model.get(now_playing).artist): ""
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
                    Layout.preferredWidth: playCont.width / 3 || 250
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
                            onClicked: {

                                now_playing -= 1
                                play()

                            }
                        }

                        Button {
                            id: playButton
                            anchors.verticalCenter: parent.verticalCenter
                            text: play_text

                            onClicked: playFunction()

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

                            onClicked: {
                                now_playing += 1
                                play()
                            }


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
                            id: duraSlider
                            Layout.fillWidth: true

                            from: 1.01
                            to: 100
                            value: 0


                            onMoved: {

                                Functions.seek(value, song_model.get(now_playing).size)

                            }

                        }

                        Text {
                            text: started ? qsTr(song_model.get(now_playing).duration) : ""
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
                            id: volumeSlider
                            from: 1.01
                            to: 100
                            value: 100

                            onMoved: {
                                Functions.controlVolume(value)
                            }
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

    // Functions
    Connections {
        target: Functions

        onCompletedPlaying: {
            play_text = music_settings.playIcon
        }

        onPropertyChanged: {
            var args = propertyNotifier
            duraSlider.value = args[0]
        }

        onStillPlaying: {
            play_text = music_settings.pauseIcon
        }

    }

    Connections {
        target: FileSys

        onStartUp: {
            songs_list = bootUp
            song_model.clear()
            song_model.append(songs_list)
            started = true
            songs_count = song_model.count

        }

        onCalled: {
            var args = callToPlay
            now_playing = args[2]
            //Functions.play(args[0], args[1])
            play()
        }

        onPropertyChanged: {
            songs_info.visible = true
            var args = propertyNotifier
            appendedSongsCount = args[0]
            song_model.clear()
            song_model.append(args[1])
            songs_count = args[0]
            songs_info_text = "We're adding"
        }

        onEndOfPropertyChange: {
            var args = endPropertyChange
            appendedSongsCount = args[0]
            songs_info_text = "We've added"
            console.log(songs_info_text)
        }

        onPropertyEnd: {
            songs_info.visible = false
        }

    }


}
