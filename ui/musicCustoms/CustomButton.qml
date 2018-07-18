import QtQuick 2.10
import QtQuick.Controls 2.3

Button {
    id: btn
    width: 36
    height: 36

    background: Rectangle {
        implicitWidth: 32
        implicitHeight: 32
        color: btn.pressed ? "dodgerblue" : "transparent"
    }

    contentItem: Text {
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Segoe MDL2 Assets"
        font.pixelSize: 16
        color: btn.pressed ? "white" : (btn.hovered ? "dodgerblue" : "black")
        renderType: Text.NativeRendering
    }

}
