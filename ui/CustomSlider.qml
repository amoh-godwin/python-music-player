import QtQuick 2.10
import QtQuick.Controls 2.3

Slider {

    background: Rectangle {
        x: parent.leftPadding
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: 108
        implicitHeight: 2
        width: parent.availableWidth
        height: implicitHeight
        color: "#25ffffff"

        Rectangle {
            width: parent.width * parent.parent.visualPosition
            height: parent.height
            color: "white"
        }
    }

    handle: Rectangle {
        x: parent.visualPosition * (parent.availableWidth - width / 2)
        y: parent.topPadding + parent.availableHeight / 2 - height / 2
        implicitWidth: 25
        implicitHeight: 25
        radius: 12.5
        color: artistTint

        Rectangle {
            anchors.centerIn: parent
            width: 17
            height: 17
            radius: 8.5
            color: "transparent"
            border.width: 3
            border.color: "white"
        }

    }

}
