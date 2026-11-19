import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Page {
    id: root

    property int editingIndex: -1
    property string initialTitle: ""
    property string initialDescription: ""
    property string initialArea: "Pesca"

    signal cancelRequested()
    signal saveRequested(string activityTitle, string activityDescription, string activityArea)

    title: editingIndex < 0 ? "Nueva actividad" : "Editar actividad"
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

        RowLayout {
            anchors.fill: parent
            spacing: 4

            Item {
                Layout.preferredWidth: 48
                Layout.preferredHeight: 48

                Text {
                    anchors.centerIn: parent
                    text: "‹"
                    color: "#111827"
                    font.pixelSize: 32
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.cancelRequested()
                }
            }

            Label {
                Layout.fillWidth: true
                text: root.title
                font.pixelSize: 20
                font.bold: true
                color: "#111827"
            }
        }
    }

    ScrollView {
        id: formScroll
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            x: 18
            y: 18
            width: formScroll.availableWidth - 36
            spacing: 9

            Label {
                Layout.fillWidth: true
                text: "Registra la actividad de la cooperativa. Los campos con * son obligatorios."
                wrapMode: Text.WordWrap
                color: "#4B5563"
            }

            Label {
                text: "Nombre de la actividad *"
                font.bold: true
                color: "#111827"
            }

            TextField {
                id: titleField
                Layout.fillWidth: true
                text: root.initialTitle
                placeholderText: "Ejemplo: revisar las redes de pesca"
                maximumLength: 80
            }

            Label {
                text: "Descripción *"
                font.bold: true
                color: "#111827"
            }

            TextArea {
                id: descriptionField
                Layout.fillWidth: true
                Layout.preferredHeight: 130
                text: root.initialDescription
                placeholderText: "Describe brevemente el trabajo por realizar"
                wrapMode: TextEdit.Wrap
            }

            Label {
                text: "Área responsable *"
                font.bold: true
                color: "#111827"
            }

            ComboBox {
                id: areaField
                Layout.fillWidth: true
                model: ["Pesca", "Mantenimiento", "Comercialización", "Administración"]
                currentIndex: Math.max(0, model.indexOf(root.initialArea))
            }

            Label {
                id: validationMessage
                Layout.fillWidth: true
                visible: text.length > 0
                wrapMode: Text.WordWrap
                color: "#B42318"
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 10
                spacing: 10

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 44
                    radius: 10
                    color: cancelMouse.pressed ? "#D1D5DB" : "#E5E7EB"

                    Text {
                        anchors.centerIn: parent
                        text: "Cancelar"
                        color: "#111827"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: cancelMouse
                        anchors.fill: parent
                        onClicked: root.cancelRequested()
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 44
                    radius: 10
                    color: saveMouse.pressed ? "#0B5F67" : "#0E7C86"

                    Text {
                        anchors.centerIn: parent
                        text: "Guardar"
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    MouseArea {
                        id: saveMouse
                        anchors.fill: parent
                        onClicked: root.submitForm()
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 12
            }
        }
    }

    function submitForm() {
        const cleanTitle = titleField.text.trim()
        const cleanDescription = descriptionField.text.trim()

        if (cleanTitle.length < 3) {
            validationMessage.text = "El nombre debe tener al menos 3 caracteres."
            titleField.forceActiveFocus()
            return
        }

        if (cleanDescription.length < 5) {
            validationMessage.text = "Describe la actividad con al menos 5 caracteres."
            descriptionField.forceActiveFocus()
            return
        }

        validationMessage.text = ""
        root.saveRequested(cleanTitle, cleanDescription, areaField.currentText)
    }
}