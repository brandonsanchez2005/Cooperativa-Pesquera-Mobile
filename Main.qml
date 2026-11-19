import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    id: appWindow

    width: 420
    height: 820
    visible: true
    title: "Cooperativa Pesquera"
    color: "#FFFFFF"

    // Botón "atrás" del celular: si estamos en el formulario,
    // cancela el cierre de la app y regresa a la lista
    onClosing: function(close) {
        if (stackView.depth > 1) {
            close.accepted = false
            stackView.pop()
        }
    }

    // Modelo de datos: lista de actividades guardada en memoria.
    // Cada actividad tiene título, descripción, área y si está hecha (done)
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

    // Controla la navegación: apila pantallas (push) y regresa (pop).
    // Empieza mostrando la lista de actividades
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: taskListComponent
    }

    // Pantalla 1: lista. Recibe el modelo y reacciona a las señales
    // que permite (agregar, editar, marcar y borrar)
    Component {
        id: taskListComponent

        TaskListPage {
            activityModel: activitiesModel

            // Abre el formulario vacío para una actividad nueva
            onAddRequested: appWindow.openActivityForm(-1)

            // Abre el formulario con los datos de la actividad elegida
            onEditRequested: function(rowIndex) {
                appWindow.openActivityForm(rowIndex)
            }

            // Invierte el estado: pendiente pasa a hecha y viceversa
            onToggleRequested: function(rowIndex) {
                const activity = activitiesModel.get(rowIndex)
                activitiesModel.setProperty(rowIndex, "done", !activity.done)
            }

            // Elimina la actividad del modelo y la lista se actualiza sola
            onDeleteRequested: function(rowIndex) {
                activitiesModel.remove(rowIndex)
            }
        }
    }

    // Pantalla 2: formulario. Sirve para crear y para editar
    Component {
        id: taskFormComponent

        TaskFormPage {
            // Cancelar: vuelve a la lista sin guardar
            onCancelRequested: stackView.pop()

            // Guardar: recibe los datos ya validados desde el formulario
            onSaveRequested: function(activityTitle, activityDescription, activityArea) {
                const rowIndex = stackView.currentItem.editingIndex

                // editingIndex -1 = actividad nueva; otro número = edición
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

    // Abre el formulario. Si rowIndex es -1 lo deja vacío; si no,
    // lo llena con los datos de esa actividad para editarla
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

        // Muestra el formulario encima de la lista con esos datos
        stackView.push(taskFormComponent, formProperties)
    }
}