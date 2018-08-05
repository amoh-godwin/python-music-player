import QtQuick 2.10
import QtQuick.Controls 2.3

TabButton {
    id: tbtn
    text: qsTr('')

    background: Rectangle {
        implicitHeight: 40
        implicitWidth: tbtn.contentItem.implicitWidth
        width: implicitWidth
        color: "transparent"

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 2
            color: "dodgerblue"
            visible: tbtn.checked ? true : false
        }

    }

    contentItem: Text {
        //width: width
        anchors.left: parent.left
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        font.family: "Segoe UI Semilight"
        font.bold: true
        color: tbtn.checked ? "black" : "#777777"
        font.pixelSize: 20
    }

}
