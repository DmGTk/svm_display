import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Rectangle {
    id: loadingScreen
    width: Screen.width
    height: Screen.height
    color: "#000000"

    property var appWindow: null
    property var loadingSteps: [
        "Loading...",
        "Key verification",
        "Integrity check",
        "Power check",
        "Connection check",
        "Starting computer unit",
        "Starting optical unit",
        "Calibration"
    ]
    property int currentStep: -1
    property real progress: 0
    property var stackView: null
    property bool showGreeting: true

    Column {
        anchors.centerIn: parent
        spacing: 16

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: loadingScreen.showGreeting ? "SVM1" : "Loading..."
            font.pixelSize: loadingScreen.showGreeting ? 28 : 22
            font.family: "monospace"
            color: "#00FFFF"
            font.bold: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: loadingScreen.showGreeting
            text: "Vibration Monitoring System"
            font.pixelSize: 18
            font.family: "monospace"
            color: "#FF00FF"
        }

        ProgressBar {
            id: progressBar
            visible: !loadingScreen.showGreeting
            width: Math.max(Math.min(parent.width * 0.7, 420), 280)
            height: 12
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 1
            value: loadingScreen.progress
            background: Rectangle {
                anchors.fill: progressBar
                color: "#000000"
                radius: 8
                border.width: 2
                border.color: "#00FFFF"
            }
            contentItem: Rectangle {
                anchors.left: progressBar.left
                anchors.verticalCenter: progressBar.verticalCenter
                height: progressBar.height - 4
                width: progressBar.width * progressBar.value
                color: "#00FFFF"
                radius: 6
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: !loadingScreen.showGreeting
            text: loadingScreen.loadingSteps[loadingScreen.currentStep] || ""
            font.pixelSize: 18
            font.family: "monospace"
            color: "#00FF00"
        }
    }

    Timer {
        id: loadTimer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if (loadingScreen.currentStep < loadingScreen.loadingSteps.length - 1) {
                loadingScreen.currentStep++
                loadingScreen.progress = (loadingScreen.currentStep + 1) / loadingScreen.loadingSteps.length
            } else {
                loadTimer.stop()
                loadingScreen.progress = 1
                if (loadingScreen.stackView) {
                    loadingScreen.stackView.replace(
                        loadingScreen.stackView.currentItem,
                        Qt.resolvedUrl("CalibrationScreen.qml"),
                        { stackView: loadingScreen.stackView, appWindow: loadingScreen.appWindow }
                    )
                }
            }
        }
    }

    Timer {
        interval: 2500
        running: true
        repeat: false
        onTriggered: {
            loadingScreen.showGreeting = false
            loadingScreen.currentStep = 0
            loadingScreen.progress = 1 / loadingScreen.loadingSteps.length
            loadTimer.start()
        }
    }
}
