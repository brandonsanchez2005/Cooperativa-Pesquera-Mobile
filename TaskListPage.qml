import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Page {
    id: root

    property var activityModel

    signal addRequested()
    signal editRequested(int rowIndex)
    signal toggleRequested(int rowIndex)
    signal deleteRequested(int rowIndex)

    title: "Cooperativa Pesquera"
    padding: 0

    background: Rectangle {
        color: "#FFFFFF"
    }

    header: ToolBar {
        contentHeight: 58
        background: Rectangle {
            color: "#FFFFFF"

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#E5E7EB"
            }
        }

        Label {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            text: "Cooperativa Pesquera"
            font.pixelSize: 20
            font.bold: true
            color: "#111827"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 12

        RowLayout {
            Layout.fillWidth: true

            Label {
                text: "Actividades de la cooperativa"
                font.pixelSize: 16
                font.bold: true
                Layout.fillWidth: true
                color: "#111827"
                wrapMode: Text.WordWrap
            }

            Rectangle {
                id: addButton
                Layout.preferredWidth: 112
                Layout.preferredHeight: 42
                radius: 10
                color: addMouse.pressed ? "#0B5F67" : "#0E7C86"

                Text {
                    anchors.centerIn: parent
                    text: "+ Agregar"
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                }

                MouseArea {
                    id: addMouse
                    anchors.fill: parent
                    onClicked: root.addRequested()
                }
            }
        }

        Label {
            Layout.fillWidth: true
            text: root.activityModel ? root.activityModel.count + " actividades" : ""
            color: "#4B5563"
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: taskList
                anchors.fill: parent
                clip: true
                spacing: 10
                model: root.activityModel

                delegate: Rectangle {
                    id: taskCard

                    required property int index
                    required property string title
                    required property string description
                    required property string area
                    required property bool done

                    width: ListView.view.width
                    implicitHeight: cardLayout.implicitHeight + 24
                    radius: 14
                    color: "white"
                    border.color: "#E5E7EB"

                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 4
                        radius: 2
                        color: taskCard.done ? "#16A34A" : "#0E7C86"
                    }

                    ColumnLayout {
                        id: cardLayout
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 6

                        RowLayout {
                            Layout.fillWidth: true

                            Label {
                                Layout.fillWidth: true
                                text: taskCard.title
                                wrapMode: Text.WordWrap
                                font.pixelSize: 16
                                font.bold: true
                                color: taskCard.done ? "#4B5563" : "#111827"
                            }

                            Label {
                                text: taskCard.area
                                color: "#075985"
                                font.bold: true
                                padding: 6
                                background: Rectangle {
                                    radius: 9
                                    color: "#E0F2FE"
                                }
                            }
                        }

                        Label {
                            Layout.fillWidth: true
                            text: taskCard.description
                            wrapMode: Text.WordWrap
                            color: "#4B5563"
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Item {
                                Layout.preferredWidth: checkRow.implicitWidth
                                Layout.preferredHeight: 40

                                Row {
                                    id: checkRow
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 8

                                    Rectangle {
                                        width: 24
                                        height: 24
                                        radius: 6
                                        color: taskCard.done ? "#0E7C86" : "white"
                                        border.color: "#0E7C86"
                                        border.width: 2

                                        Text {
                                            anchors.centerIn: parent
                                            visible: taskCard.done
                                            text: "✓"
                                            color: "white"
                                            font.pixelSize: 16
                                            font.bold: true
                                        }
                                    }

                                    Label {
                                        height: 24
                                        verticalAlignment: Text.AlignVCenter
                                        text: taskCard.done ? "Hecha" : "Pendiente"
                                        color: "#111827"
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: root.toggleRequested(taskCard.index)
                                }
                            }

                            Item {
                                Layout.fillWidth: true
                            }

                            Rectangle {
                                id: editButton
                                Layout.preferredWidth: 72
                                Layout.preferredHeight: 36
                                radius: 8
                                color: editMouse.pressed ? "#1D4ED8" : "#2563EB"

                                Text {
                                    anchors.centerIn: parent
                                    text: "Editar"
                                    color: "white"
                                    font.pixelSize: 12
                                    font.bold: true
                                }

                                MouseArea {
                                    id: editMouse
                                    anchors.fill: parent
                                    onClicked: root.editRequested(taskCard.index)
                                }
                            }

                            Rectangle {
                                id: deleteButton
                                Layout.preferredWidth: 72
                                Layout.preferredHeight: 36
                                radius: 8
                                color: deleteMouse.pressed ? "#B91C1C" : "#DC2626"

                                Text {
                                    anchors.centerIn: parent
                                    text: "Borrar"
                                    color: "white"
                                    font.pixelSize: 12
                                    font.bold: true
                                }

                                MouseArea {
                                    id: deleteMouse
                                    anchors.fill: parent
                                    onClicked: root.deleteRequested(taskCard.index)
                                }
                            }
                        }
                    }
                }
            }

            Label {
                anchors.centerIn: parent
                width: parent.width * 0.8
                visible: root.activityModel && root.activityModel.count === 0
                text: "No hay actividades registradas. Pulsa + Agregar para comenzar."
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#4B5563"
            }
        }
    }
}