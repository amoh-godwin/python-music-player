import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Button {

    id: btn


    background: Rectangle {
        implicitHeight: 48

        color: btn.hovered ? "#e1e1e1" : "transparent"

        Rectangle {
            id: border
            width: 4
            height: parent.height
            color: "dodgerblue"
            visible: btn.pressed
        }

    }

    contentItem: RowLayout {
        height: 48
        property string menuName: qsTr('My music')
        property string iconSource: "icons/ic_queue_music_black_48dp.png"


        Image {
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 24
            sourceSize.height: 24
            source: btn.icon.source
        }

        Text {
            anchors.left: parent.children[0].right
            anchors.leftMargin: 12
            text: btn.text
            font.family: "Segoe UI"
            renderType: Text.QtRendering
            color: "#1e1e1e"
            font.pixelSize: 16
        }

    }

}
