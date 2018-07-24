import QtQuick 2.10
import QtQuick.Controls 2.3

ToolButton {
    id: btnCtrl

    property string iconSource: ""
    signal clicked()

    background: Rectangle {

        implicitHeight: 50
        color: btnCtrl.hovered ? Qt.darker(ctrl.curr_color, 1.2) : "transparent"

        Rectangle {
            width: 4
            height: parent.height
            color: "dodgerblue"
            visible: btnCtrl.text == music_settings.navIcon || btnCtrl.text == music_settings.searchIcon ? false: btnCtrl.checked
        }

    }

    contentItem: Text {
        text: parent.text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Segoe MDL2 Assets"
        font.pixelSize: 18
        renderType: Text.NativeRendering
        color: ctrl.ListView.isCurrentItem ? "white" : "black"
    }


    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            ctrl.hovered = true
        }

        onClicked: parent.clicked()

        onExited: ctrl.hovered = false

    }

}
