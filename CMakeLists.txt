cmake_minimum_required(VERSION 3.16)

project(CooperativaPesquera VERSION 1.0 LANGUAGES CXX)

# Busca Qt 6.8 o superior con el módulo Quick (interfaces QML)
find_package(Qt6 6.8 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

# Crea el ejecutable de la app a partir de main.cpp
qt_add_executable(appCooperativaPesquera
    main.cpp
)

# Registra el módulo QML con sus tres pantallas
qt_add_qml_module(appCooperativaPesquera
    URI CooperativaPesquera
    VERSION 1.0
    QML_FILES
        Main.qml
        TaskListPage.qml
        TaskFormPage.qml
)

# Enlaza la librería Qt Quick con la app
target_link_libraries(appCooperativaPesquera
    PRIVATE
        Qt6::Quick
)

# Ajustes de empaquetado para Windows y macOS
set_target_properties(appCooperativaPesquera PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)