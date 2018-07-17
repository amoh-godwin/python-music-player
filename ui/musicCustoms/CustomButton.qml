import QtQuick 2.10
import QtQuick.Controls 2.3

Button {
    id: btn
    width: 36
    height: 36
    icon.color: if(btn.pressed) {
                    "white"
                } else if(btn.hovered) {
                    "dodgerblue"
                }else {
                    "black"
                }

    background: Rectangle {
        implicitWidth: 32
        implicitHeight: 32
        color: btn.pressed ? "dodgerblue" : "transparent"
    }

}
