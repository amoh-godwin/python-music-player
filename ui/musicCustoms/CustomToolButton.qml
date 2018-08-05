import QtQuick 2.10
import QtQuick.Controls 2.3

ToolButton {
    id: ctrl

    property string iconSource: ""

    background: Rectangle {

        implicitHeight: 48
        height: implicitHeight
        color: parent.hovered ? "#e1e1e1" : "transparent"

        Rectangle {
            width: 4
            height: parent.height
            color: "dodgerblue"
            visible: ctrl.text == music_settings.navIcon || ctrl.text == music_settings.searchIcon ? false: ctrl.checked
        }

    }

    contentItem: Text {
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Segoe MDL2 Assets"
        font.pixelSize: 18
        renderType: Text.NativeRendering
    }

}
