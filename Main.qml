import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: appWindow

    width: 420
    height: 820
    visible: true
    title: "Cooperativa Pesquera"
    color: "#FFFFFF"

    ListModel {
        id: activitiesModel

        ListElement {
            title: "Coordinar salida de pesca"
            description: "Confirmar embarcación, tripulación y horario de salida."
            area: "Pesca"
            done: false
        }
        ListElement {
            title: "Revisar redes y equipos"
            description: "Inspeccionar las redes y registrar si necesitan reparación."
            area: "Mantenimiento"
            done: false
        }
        ListElement {
            title: "Preparar entrega para el mercado"
            description: "Organizar el producto y confirmar el pedido del cliente."
            area: "Comercialización"
            done: false
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: taskListComponent
    }

    Component {
        id: taskListComponent

        TaskListPage {
            activityModel: activitiesModel

            onAddRequested: appWindow.openActivityForm(-1)

            onEditRequested: function(rowIndex) {
                appWindow.openActivityForm(rowIndex)
            }

            onToggleRequested: function(rowIndex) {
                const activity = activitiesModel.get(rowIndex)
                activitiesModel.setProperty(rowIndex, "done", !activity.done)
            }

            onDeleteRequested: function(rowIndex) {
                activitiesModel.remove(rowIndex)
            }
        }
    }

    Component {
        id: taskFormComponent

        TaskFormPage {
            onCancelRequested: stackView.pop()

            onSaveRequested: function(activityTitle, activityDescription, activityArea) {
                const rowIndex = stackView.currentItem.editingIndex

                if (rowIndex < 0) {
                    activitiesModel.append({
                        "title": activityTitle,
                        "description": activityDescription,
                        "area": activityArea,
                        "done": false
                    })
                } else {
                    activitiesModel.setProperty(rowIndex, "title", activityTitle)
                    activitiesModel.setProperty(rowIndex, "description", activityDescription)
                    activitiesModel.setProperty(rowIndex, "area", activityArea)
                }

                stackView.pop()
            }
        }
    }

    function openActivityForm(rowIndex) {
        let formProperties = {
            "editingIndex": -1,
            "initialTitle": "",
            "initialDescription": "",
            "initialArea": "Pesca"
        }

        if (rowIndex >= 0) {
            const activity = activitiesModel.get(rowIndex)
            formProperties = {
                "editingIndex": rowIndex,
                "initialTitle": activity.title,
                "initialDescription": activity.description,
                "initialArea": activity.area
            }
        }

        stackView.push(taskFormComponent, formProperties)
    }
}
