import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
//import ""

Component {
    id: lvDelegate


    Rectangle {

        id: ctrl

        property bool hovered: false
        property color curr_color: "dodgerblue"

        width: parent.width
        height: 50
        color: ctrl.ListView.isCurrentItem ? ctrl.curr_color : ( ctrl.hovered ? "#e1e1e1" : (index % 2 ? "white" : "#f1f1f1") )


        RowLayout {

            anchors.left: parent.left
            anchors.leftMargin: 12
            width: parent.width - 12
            height: parent.height
            spacing: 12

            CheckBox {
                Layout.preferredWidth: 22

                indicator: Rectangle {
                    anchors.centerIn: parent
                    implicitWidth: 22
                    implicitHeight: 22
                    color: "transparent"
                    border.width: 1
                    border.color: ctrl.ListView.isCurrentItem ? "white" :"black"
                    visible: ctrl.ListView.isCurrentItem || ctrl.hovered ? true : false
                }

            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"
                Text {
                    width: parent.width
                    rightPadding: 8
                    anchors.verticalCenter: parent.verticalCenter
                    clip: true
                    text: qsTr("Rivers of Jordan || busysinging.com")
                    font.pixelSize: 16
                    font.family: "Segoe UI Semilight"
                    color: ctrl.ListView.isCurrentItem ? "white" :"black"
                }

                Rectangle {
                    anchors.right: parent.right
                    width: 104
                    height: parent.height
                    color: "#e1e1e1"
                    visible: ctrl.ListView.isCurrentItem ? true : false

                    Row {
                        anchors.right: parent.right
                        width: 96

                        CustomToolButton {
                            width: 48
                            iconSource: "icons/ic_play_arrow_black_48dp.png"
                        }

                        CustomToolButton {
                            width: 48
                            iconSource: "icons/ic_add_black_48dp.png"
                        }


                    }

                }

            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Lecrae")
                    font.pixelSize: 13
                    font.family: "Segoe UI Semilight"
                    color: ctrl.ListView.isCurrentItem ? "white" :"black"
                }
            }

            Rectangle {
                width: 36
                Layout.fillHeight: true
                color: "transparent"

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "1:10:12"
                    font.family: "Segoe UI Semilight"
                    font.pixelSize: 13
                    color: ctrl.ListView.isCurrentItem ? "white" :"black"
                }
            }

            Rectangle {
                anchors.right: parent.right
                Layout.preferredWidth: 136
                Layout.fillHeight: true
                color: "transparent"

                Rectangle {
                    anchors.centerIn: parent
                    width: local.width
                    height: local.height
                    border.color: ctrl.ListView.isCurrentItem ? "white" :"black"
                    color: "transparent"
                    Text {
                        topPadding: 2
                        leftPadding: 3
                        bottomPadding: 2
                        rightPadding: 3
                        id: local
                        text: "LOCAL ONLY"
                        font.family: "Segoe UI Light"
                        font.pixelSize: 10
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: ctrl.ListView.isCurrentItem ? "white" :"black"
                    }
                }

            }

        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                ctrl.hovered = true
            }

            onClicked: {
                var index = songs_view.indexAt(parent.x, parent.y)
                songs_view.currentIndex = index
            }

            onExited: {
                ctrl.hovered = false
            }

        }

    }

}
