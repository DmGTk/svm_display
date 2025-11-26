import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Rectangle {
    id: workingMode
    anchors.fill: undefined    // avoid StackView anchor conflicts
    width: parent ? parent.width : 800
    height: parent ? parent.height : 480
    color: "#000000"

    property string mode: "operator"
    property var appWindow: null
    property var stackView: null

    property real temperature: 22.5
    property real vibration: 0.3
    property real voltage: 221
    property bool showLog: false
    property var logEntries: [
        { "timestamp": "2025-10-28 14:32:15", "level": "info", "message": "System started in ADMINISTRATOR MODE" },
        { "timestamp": "2025-10-28 14:32:16", "level": "info", "message": "All sensors initialized successfully" },
        { "timestamp": "2025-10-28 14:32:45", "level": "info", "message": "Temperature: 22.5C, Status: NORMAL" },
        { "timestamp": "2025-10-28 14:33:12", "level": "warning", "message": "Vibration level increased: 0.85 mm/s" },
        { "timestamp": "2025-10-28 14:33:30", "level": "info", "message": "Voltage: 218V, Status: NORMAL" },
        { "timestamp": "2025-10-28 14:34:01", "level": "info", "message": "Temperature: 23.1C, Status: NORMAL" },
        { "timestamp": "2025-10-28 14:34:22", "level": "warning", "message": "Temperature warning: 46.2C" },
        { "timestamp": "2025-10-28 14:34:45", "level": "error", "message": "Critical temperature: 56.8C" },
        { "timestamp": "2025-10-28 14:35:10", "level": "info", "message": "Temperature normalized: 44.3C" },
        { "timestamp": "2025-10-28 14:35:32", "level": "info", "message": "All parameters within normal range" }
    ]

    function statusColor() {
        return systemStatus() === "error" ? "#FF073A" :
               (systemStatus() === "warning" ? "#FFA500" : "#00C000")
    }

    function temperatureStatus(temp) {
        if (temp > 55) return "error"
        if (temp > 45) return "warning"
        return "normal"
    }

    function vibrationStatus(vib) {
        if (vib > 1.2) return "error"
        if (vib > 0.8) return "warning"
        return "normal"
    }

    function voltageStatus(volt) {
        if (volt < 200 || volt > 240) return "error"
        if (volt < 210 || volt > 230) return "warning"
        return "normal"
    }

    function systemStatus() {
        var statuses = [temperatureStatus(temperature), vibrationStatus(vibration), voltageStatus(voltage)];
        if (statuses.indexOf("error") !== -1) return "error";
        if (statuses.indexOf("warning") !== -1) return "warning";
        return "normal";
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            temperature = Math.max(20, Math.min(70, temperature + (Math.random() - 0.5) * 2));
            vibration = Math.max(0, Math.min(2, vibration + (Math.random() - 0.5) * 0.2));
            voltage = Math.max(200, Math.min(240, voltage + (Math.random() - 0.5) * 5));
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Math.min(workingMode.width, workingMode.height) * 0.04
        spacing: 20

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 8
            Text {
                text: "SVM1"
                font.pixelSize: 22
                font.family: "monospace"
                color: "#00FFFF"
                font.bold: true
            }
            Item { Layout.fillWidth: true }
            Text {
                text: mode === "operator" ? "[OPERATOR MODE]" : "[ADMINISTRATOR MODE]"
                font.pixelSize: 14
                font.family: "monospace"
                color: "#FF00FF"
                font.bold: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 16

            Column {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                spacing: 12
                width: statusCircle.width

                Rectangle {
                    id: statusCircle
                    width: Math.min(180, workingMode.width * 0.25)
                    height: width
                    radius: width / 2
                    color: statusColor()

                    SequentialAnimation on scale {
                        loops: Animation.Infinite
                        NumberAnimation { from: 1.0; to: 1.05; duration: 800; easing.type: Easing.InOutQuad }
                        NumberAnimation { from: 1.05; to: 1.0; duration: 800; easing.type: Easing.InOutQuad }
                    }
                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        NumberAnimation { from: 0.85; to: 1; duration: 800 }
                        NumberAnimation { from: 1; to: 0.85; duration: 800 }
                    }
                }

                Text {
                    anchors.horizontalCenter: statusCircle.horizontalCenter
                    text: systemStatus() === "error" ? "ALERT" :
                          (systemStatus() === "warning" ? "WARNING" : "NORMAL")
                    font.pixelSize: 16
                    font.family: "monospace"
                    color: statusColor()
                    font.bold: true
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.preferredWidth: Math.min(540, workingMode.width * 0.7)
                spacing: 12

                Rectangle {
                    id: tempCard
                    Layout.fillWidth: true
                    Layout.preferredHeight: 72
                    color: "#000000"
                    border.width: 3
                    property color barColor: "#00FF00"
                    border.color: barColor

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 14
                        spacing: 10
                        Text {
                            text: "TEMPERATURE"
                            font.family: "monospace"
                            font.pixelSize: 15
                            color: tempCard.barColor
                            font.bold: true
                        }
                        Item { Layout.fillWidth: true }
                        Text {
                            text: temperature.toFixed(1) + " C"
                            font.family: "monospace"
                            font.pixelSize: 17
                            color: tempCard.barColor
                            font.bold: true
                        }
                    }
                }

                Rectangle {
                    id: vibCard
                    Layout.fillWidth: true
                    Layout.preferredHeight: 72
                    color: "#000000"
                    border.width: 3
                    property color barColor: "#00FF00"
                    border.color: barColor

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 14
                        spacing: 10
                        Text {
                            text: "VIBRATION"
                            font.family: "monospace"
                            font.pixelSize: 15
                            color: vibCard.barColor
                            font.bold: true
                        }
                        Item { Layout.fillWidth: true }
                        Text {
                            text: vibration.toFixed(2) + " mm/s"
                            font.family: "monospace"
                            font.pixelSize: 17
                            color: vibCard.barColor
                            font.bold: true
                        }
                    }
                }

                Rectangle {
                    id: voltCard
                    Layout.fillWidth: true
                    Layout.preferredHeight: 72
                    color: "#000000"
                    border.width: 3
                    property color barColor: "#00FF00"
                    border.color: barColor

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 14
                        spacing: 10
                        Text {
                            text: "POWER VOLTAGE"
                            font.family: "monospace"
                            font.pixelSize: 15
                            color: voltCard.barColor
                            font.bold: true
                        }
                        Item { Layout.fillWidth: true }
                        Text {
                            text: voltage.toFixed(0) + " V"
                            font.family: "monospace"
                            font.pixelSize: 17
                            color: voltCard.barColor
                            font.bold: true
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                height: 64
                color: "#000000"
                border.width: 3
                border.color: "#FF007A"
                Text {
                    anchors.centerIn: parent
                    text: "STOP"
                    font.pixelSize: 15
                    font.family: "monospace"
                    color: "#FF007A"
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (appWindow) {
                            appWindow.stopWorking()
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 64
                color: "#000000"
                border.width: 3
                border.color: "#FF00FF"
                Text {
                    anchors.centerIn: parent
                    text: "CHANGE MODE"
                    font.pixelSize: 15
                    font.family: "monospace"
                    color: "#FF00FF"
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (appWindow) {
                            appWindow.isRunning = false
                            appWindow.currentMode = ""
                            appWindow.showModeSelection()
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 64
                color: "#000000"
                border.width: 3
                border.color: "#00FFFF"
                Text {
                    anchors.centerIn: parent
                    text: "VIEW LOG"
                    font.pixelSize: 15
                    font.family: "monospace"
                    color: "#00FFFF"
                    font.bold: true
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        workingMode.showLog = true
                    }
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: showLog ? "#80000000" : "transparent"
        visible: showLog
        z: 10

        Rectangle {
            width: 660
            height: 420
            radius: 12
            color: "#000000"
            border.width: 3
            border.color: "#00FFFF"
            anchors.centerIn: parent

            Column {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                Row {
                    spacing: 8
                    Text {
                        text: "SYSTEM LOG"
                        font.family: "monospace"
                        font.pixelSize: 18
                        color: "#00FFFF"
                        font.bold: true
                    }
                }

                Flickable {
                    id: logFlick
                    anchors.left: parent.left
                    anchors.right: parent.right
                    contentHeight: logCol.implicitHeight
                    height: 280
                    clip: true

                    Column {
                        id: logCol
                        width: logFlick.width
                        spacing: 6

                        Repeater {
                            model: logEntries
                            delegate: Row {
                                width: logCol.width
                                spacing: 6

                                property string lvl: modelData.level

                                function levelColor(lvl) {
                                    if (lvl === "error") return "#FF073A";
                                    if (lvl === "warning") return "#FFA500";
                                    return "#00FFFF";
                                }

                                Text {
                                    text: modelData.timestamp
                                    color: "#00FF00"
                                    font.family: "monospace"
                                    font.pixelSize: 12
                                }
                                Text {
                                    text: "[" + modelData.level.toUpperCase() + "]"
                                    color: levelColor(lvl)
                                    font.family: "monospace"
                                    font.pixelSize: 12
                                }
                                Text {
                                    text: modelData.message
                                    color: "#CCCCCC"
                                    font.family: "monospace"
                                    font.pixelSize: 12
                                    wrapMode: Text.Wrap
                                }
                            }
                        }
                    }
                }

                Row {
                    spacing: 12
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        width: 260
                        height: 48
                        color: "#000000"
                        radius: 4
                        border.width: 3
                        border.color: "#FF00FF"
                        Text {
                            anchors.centerIn: parent
                            text: "SAVE TO USB"
                            font.pixelSize: 14
                            font.family: "monospace"
                            color: "#FF00FF"
                            font.bold: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("Save to USB clicked (stub)");
                            }
                        }
                    }

                    Rectangle {
                        width: 260
                        height: 48
                        color: "#000000"
                        radius: 4
                        border.width: 3
                        border.color: "#00FFFF"
                        Text {
                            anchors.centerIn: parent
                            text: "CLOSE"
                            font.pixelSize: 14
                            font.family: "monospace"
                            color: "#00FFFF"
                            font.bold: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                workingMode.showLog = false;
                            }
                        }
                    }
                }
            }
        }
    }
}

