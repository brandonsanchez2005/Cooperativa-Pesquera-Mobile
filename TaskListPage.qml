import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Page {
    id: root

    // Modelo de actividades que llega desde Main.qml
    property var activityModel

    // Señales: la lista solo avisa qué pidió el usuario;
    // Main.qml es quien modifica los datos
    signal addRequested()
    signal editRequested(int rowIndex)
    signal toggleRequested(int rowIndex)
    signal deleteRequested(int rowIndex)

    title: "Cooperativa Pesquera"
    padding: 0

    background: Rectangle {
        color: "#FFFFFF"
    }

    // Barra superior con el nombre de la app
    header: ToolBar {
        contentHeight: 58
        background: Rectangle {
            color: "#FFFFFF"

            // Línea gris inferior para separar la barra del contenido
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

    // Columna principal: encabezado, contador y lista
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

            // Botón Agregar: Rectangle con MouseArea (zona que detecta el toque)
            Rectangle {
                id: addButton
                Layout.preferredWidth: 112
                Layout.preferredHeight: 42
                radius: 10
                // Cambia de color mientras se mantiene presionado
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

        // Contador: se actualiza solo al agregar o borrar actividades
        Label {
            Layout.fillWidth: true
            text: root.activityModel ? root.activityModel.count + " actividades" : ""
            color: "#4B5563"
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // ListView crea una tarjeta (delegate) por cada actividad del modelo
            ListView {
                id: taskList
                anchors.fill: parent
                clip: true
                spacing: 10
                model: root.activityModel

                // Tarjeta de una actividad. Las "required property" reciben
                // los datos de cada fila del modelo
                delegate: Rectangle {
                    id: taskCard

                    required property int index
                    required property string title
                    required property string description
                    required property string area
                    required property bool done

                    width: ListView.view.width
                    // Altura automática según el contenido de la tarjeta
                    implicitHeight: cardLayout.implicitHeight + 24
                    radius: 14
                    color: "white"
                    border.color: "#E5E7EB"

                    // Franja lateral: verde si está hecha, turquesa si está pendiente
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

                            // Título: se ve gris cuando la actividad está hecha
                            Label {
                                Layout.fillWidth: true
                                text: taskCard.title
                                wrapMode: Text.WordWrap
                                font.pixelSize: 16
                                font.bold: true
                                color: taskCard.done ? "#4B5563" : "#111827"
                            }

                            // Etiqueta con el área (Pesca, Mantenimiento, etc.)
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

                            // Casilla hecha a mano: cuadro + texto, con un
                            // MouseArea encima para detectar el toque
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

                                        // La palomita solo aparece si está hecha
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

                                // Al tocar, envía la posición (index) de esta actividad
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: root.toggleRequested(taskCard.index)
                                }
                            }

                            // Espacio flexible que empuja los botones a la derecha
                            Item {
                                Layout.fillWidth: true
                            }

                            // Botón Editar
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

                            // Botón Borrar
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

            // Mensaje que solo aparece cuando no hay actividades
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