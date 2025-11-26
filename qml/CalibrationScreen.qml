import QtQuick.Window 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: calibrationScreen
    anchors.fill: parent
    color: "#000000"

    property int progress: 0
    property bool isComplete: false
    property var stackView: null
    property var appWindow: null

    Column {
        anchors.centerIn: parent
        spacing: 18

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "System Calibration"
            font.pixelSize: 24
            font.family: "monospace"
            color: "#00FFFF"
        }

        ProgressBar {
            id: calibrationProgressBar
            width: Math.max(Math.min(parent.width * 0.7, 420), 280)
            height: 12
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 100
            value: calibrationScreen.progress
            visible: !calibrationScreen.isComplete
            background: Rectangle {
                color: "#000000"
                radius: 8
                border.width: 2
                border.color: "#00FFFF"
            }
            contentItem: Rectangle {
                anchors.left: calibrationProgressBar.left
                anchors.verticalCenter: calibrationProgressBar.verticalCenter
                height: calibrationProgressBar.height - 4
                width: calibrationProgressBar.width * (calibrationProgressBar.value / 100)
                color: "#00FFFF"
                radius: 6
            }
        }

        Column {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: calibrationScreen.isComplete ? "✔ Success" : ""
                font.pixelSize: 18
                font.family: "monospace"
                color: "#00FF00"
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: Math.round(calibrationScreen.progress) + "%"
                font.pixelSize: 16
                font.family: "monospace"
                color: "#FF00FF"
            }
        }
    }

    Timer {
        id: calibrationTimer
        interval: 30    // ~3 seconds total for 100 steps
        running: true
        repeat: true
        onTriggered: {
            if (calibrationScreen.progress < 100) {
                calibrationScreen.progress += 1
            } else {
                calibrationScreen.isComplete = true
                calibrationTimer.stop()
                completionDelay.start()
            }
        }
    }

    Timer {
        id: completionDelay
        interval: 1500
        running: false
        repeat: false
        onTriggered: {
            if (calibrationScreen.stackView && calibrationScreen.appWindow) {
                calibrationScreen.stackView.replace(
                    calibrationScreen.stackView.currentItem,
                    Qt.resolvedUrl("MainMenu.qml"),
                    {
                        stackView: calibrationScreen.stackView,
                        appWindow: calibrationScreen.appWindow,
                        isRunning: calibrationScreen.appWindow.isRunning
                    }
                )
            }
        }
    }
}
