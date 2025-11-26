import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Rectangle {
    width: Screen.width
    height: Screen.height
    color: "#000000"

    property var stackView: null
    property var appWindow: null

    Column {
        anchors.centerIn: parent
        spacing: 26

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Select Mode"
            font.family: "monospace"
            font.pixelSize: 24
            color: "#00FFFF"
            font.bold: true
        }

        Rectangle {
            width: 520
            height: 100
            color: "transparent"
            radius: 4
            border.width: 3
            border.color: "#FF00FF"

            Text {
                anchors.centerIn: parent
                text: "OPERATOR MODE"
                font.family: "monospace"
                font.pixelSize: 18
                color: "#FF00FF"
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (appWindow) {
                        appWindow.startWorking("operator")
                    }
                }
            }
        }

        Rectangle {
            width: 520
            height: 100
            color: "transparent"
            radius: 4
            border.width: 3
            border.color: "#00FFFF"

            Text {
                anchors.centerIn: parent
                text: "ADMINISTRATOR MODE"
                font.family: "monospace"
                font.pixelSize: 18
                color: "#00FFFF"
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (appWindow) {
                        appWindow.startWorking("admin")
                    }
                }
            }
        }
    }
}
