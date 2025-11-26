pragma ComponentBehavior: Bound
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "qml"

ApplicationWindow {
    id: appWindow
    property alias mainStack: stackView
    property bool isRunning: false
    property string currentMode: ""
    property int targetWidth: (typeof primaryScreenWidth !== "undefined" ? primaryScreenWidth : Screen.width)
    property int targetHeight: (typeof primaryScreenHeight !== "undefined" ? primaryScreenHeight : Screen.height)
    visible: true
    width: targetWidth
    height: targetHeight
    visibility: Window.FullScreen
    title: "SVM-1"
    color: "#000000"

    Component.onCompleted: {
        // Ensure we cover the detected screen size; FullScreen avoids window chrome on Pi
        if (visibility !== Window.FullScreen) {
            this.showFullScreen()
        }
    }

    function showCalibration() {
        stackView.replace(stackView.currentItem, calibrationComponent)
    }

    function showMainMenu() {
        stackView.replace(stackView.currentItem, mainMenuComponent)
    }

    function showModeSelection() {
        stackView.replace(stackView.currentItem, modeSelectionComponent)
    }

    function startWorking(modeValue) {
        appWindow.currentMode = modeValue
        appWindow.isRunning = true
        stackView.replace(stackView.currentItem, workingModeComponent)
    }

    function stopWorking() {
        appWindow.isRunning = false
        appWindow.currentMode = ""
        stackView.replace(stackView.currentItem, mainMenuComponent)
    }

    Component {
        id: loadingComponent
        LoadingScreen {
            stackView: stackView
            appWindow: appWindow
        }
    }

    Component {
        id: calibrationComponent
        CalibrationScreen {
            stackView: stackView
            appWindow: appWindow
        }
    }

    Component {
        id: mainMenuComponent
        MainMenu {
            stackView: stackView
            appWindow: appWindow
            isRunning: appWindow.isRunning
        }
    }

    Component {
        id: modeSelectionComponent
        ModeSelection {
            stackView: stackView
            appWindow: appWindow
        }
    }

    Component {
        id: workingModeComponent
        WorkingMode {
            stackView: stackView
            appWindow: appWindow
            mode: appWindow.currentMode
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: loadingComponent
    }
}
