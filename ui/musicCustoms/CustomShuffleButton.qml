import QtQuick 2.10
import QtQuick.Controls 2.3

Button {
    id: ctrl
    text: ''

    property string unicon: ""
    property int uniconSize: 16
    property string secText: ""

    background: Rectangle {
        implicitWidth: 16
        implicitHeight: 48

        Text {
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Segoe MDL2 Assets"
            text: ctrl.unicon
            font.pixelSize: ctrl.uniconSize
            visible: ctrl.unicon ? true : false
        }

    }

    contentItem: Text {
        id: xt
        textFormat: Text.RichText
        leftPadding: ctrl.text === "" ? 0 : (ctrl.unicon ? 24 : 0)
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 16
        text: parent.text + ' <span style="color: #298FCC">' + ctrl.secText + '</span>'
        font.family: "Segoe UI"
        font.pixelSize: 13
        color: ctrl.hovered ? "#99000000" : "black"
    }
}
