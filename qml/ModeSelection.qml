import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Rectangle {
    anchors.fill: parent
    color: "#000000"

    property var stackView: null
    property var appWindow: null

    Column {
        anchors.centerIn: parent
        spacing: Math.max(16, Math.min((parent ? parent.height : height) * 0.04, 28))
        anchors.margins: Math.max(12, Math.min(parent ? parent.width : width, parent ? parent.height : height) * 0.03)

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Select Mode"
            font.family: "monospace"
            font.pixelSize: Math.max(20, Math.min(height * 0.05, 28))
            color: "#00FFFF"
            font.bold: true
        }

        Rectangle {
            width: Math.max(220, Math.min(parent.width * 0.85, 520))
            height: Math.max(84, Math.min(parent.height * 0.18, 110))
            color: "transparent"
            radius: 4
            border.width: 3
            border.color: "#FF00FF"

            Text {
                anchors.centerIn: parent
                text: "OPERATOR MODE"
                font.family: "monospace"
                font.pixelSize: Math.max(16, Math.min(parent.height * 0.18 * 0.22, 22))
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
            width: Math.max(220, Math.min(parent.width * 0.85, 520))
            height: Math.max(84, Math.min(parent.height * 0.18, 110))
            color: "transparent"
            radius: 4
            border.width: 3
            border.color: "#00FFFF"

            Text {
                anchors.centerIn: parent
                text: "ADMINISTRATOR MODE"
                font.family: "monospace"
                font.pixelSize: Math.max(16, Math.min(parent.height * 0.18 * 0.22, 22))
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
