import QtQuick
import QtQuick.Controls
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

            Button {
                id: addButton
                text: "+ Agregar"
                Layout.preferredWidth: 112
                Layout.minimumWidth: 112
                Layout.preferredHeight: 42
                font.pixelSize: 14
                background: Rectangle {
                    radius: 10
                    color: addButton.down ? "#0B5F67" : "#0E7C86"
                }
                contentItem: Text {
                    text: addButton.text
                    color: "white"
                    font: addButton.font
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: root.addRequested()
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

                            CheckBox {
                                text: taskCard.done ? "Hecha" : "Pendiente"
                                checked: taskCard.done
                                onToggled: root.toggleRequested(taskCard.index)
                            }

                            Item {
                                Layout.fillWidth: true
                            }

                            Button {
                                id: editButton
                                text: "Editar"
                                Layout.preferredWidth: 72
                                Layout.preferredHeight: 36
                                font.pixelSize: 12
                                background: Rectangle {
                                    radius: 8
                                    color: editButton.down ? "#1D4ED8" : "#2563EB"
                                }
                                contentItem: Text {
                                    text: editButton.text
                                    color: "white"
                                    font: editButton.font
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: root.editRequested(taskCard.index)
                            }

                            Button {
                                id: deleteButton
                                text: "Borrar"
                                Layout.preferredWidth: 72
                                Layout.preferredHeight: 36
                                font.pixelSize: 12
                                background: Rectangle {
                                    radius: 8
                                    color: deleteButton.down ? "#B91C1C" : "#DC2626"
                                }
                                contentItem: Text {
                                    text: deleteButton.text
                                    color: "white"
                                    font: deleteButton.font
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onClicked: root.deleteRequested(taskCard.index)
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
