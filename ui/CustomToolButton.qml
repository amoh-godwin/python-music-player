import QtQuick 2.10
import QtQuick.Controls 2.3

ToolButton {


    property url iconSource: ""


    icon.source: iconSource

    background: Rectangle {

        implicitHeight: 50
        color: parent.hovered ? "#e1e1e1" : "transparent"
    }

}
