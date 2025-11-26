import QtQuick 2.15
import QtQuick.Controls 2.15

Dialog {
    id: logViewerDialog
    visible: true

    title: "Logs"

    ScrollView {
        width: parent.width
        height: parent.height

        Column {
            spacing: 10

            // Пример логов
            Repeater {
                model: ListModel {
                    ListElement { timestamp: "2023-01-01 12:00:00"; level: "info"; message: "System initialized" }
                    ListElement { timestamp: "2023-01-01 12:05:00"; level: "warning"; message: "Low battery" }
                    ListElement { timestamp: "2023-01-01 12:10:00"; level: "error"; message: "Sensor failure" }
                }

                delegate: Row {
                    Text {
                        text: timestamp + " [" + level + "] " + message
                        color: level === "error" ? "#FF0000" : (level === "warning" ? "#FFFF00" : "#00FF00")
                    }
                }
            }
        }
    }
}
