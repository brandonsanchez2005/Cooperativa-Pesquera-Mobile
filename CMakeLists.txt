cmake_minimum_required(VERSION 3.16)

project(CooperativaPesquera VERSION 1.0 LANGUAGES CXX)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appCooperativaPesquera
    main.cpp
)

qt_add_qml_module(appCooperativaPesquera
    URI CooperativaPesquera
    VERSION 1.0
    QML_FILES
        Main.qml
        TaskListPage.qml
        TaskFormPage.qml
)

target_link_libraries(appCooperativaPesquera
    PRIVATE
        Qt6::Quick
)

set_target_properties(appCooperativaPesquera PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)
