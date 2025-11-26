import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Item {
    width: Screen.width
    height: Screen.height

    property var stackView: null
    property var appWindow: null
    property bool isRunning: false

    Rectangle {
        anchors.fill: parent
        color: "#000000"

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 28

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "SVM1"
                font.family: "monospace"
                font.pixelSize: 32
                color: "#00FFFF"
                font.bold: true
            }

            Rectangle {
                width: 260
                height: 90
                radius: 4
                color: "transparent"
                border.width: 3
                border.color: isRunning ? "#FF007A" : "#00FF00"

                Text {
                    anchors.centerIn: parent
                    text: isRunning ? "STOP" : "START"
                    font.pixelSize: 20
                    font.family: "monospace"
                    color: isRunning ? "#FF007A" : "#00FF00"
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (isRunning && appWindow) {
                            appWindow.stopWorking()
                        } else if (appWindow) {
                            appWindow.showModeSelection()
                        }
                    }
                }
            }
        }
    }
}
