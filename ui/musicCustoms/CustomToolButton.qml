import QtQuick 2.10
import QtQuick.Controls 2.3

ToolButton {
    id: ctrl

    property string iconSource: ""

    background: Rectangle {

        implicitHeight: 50
        color: parent.hovered ? "#e1e1e1" : "transparent"
    }

    contentItem: Text {
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Segoe MDL2 Assets"
        font.pixelSize: 20
        renderType: Text.NativeRendering
    }

}
