cmake_minimum_required(VERSION 3.16)

project(desktopPet VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

# Content of downloaded design from Figma to Qt or similar
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(appdesktopPet
    main.cpp
)

qt_add_qml_module(appdesktopPet
    URI desktopPet
    QML_FILES
        MainWindow.qml
        components/ContentView.qml
        components/PetCharacter.qml
        components/SourceAnimation.qml
        components/SpeechBubble.qml
        services/DateService.js
        content/ContentProvider.js
        content/AnniversaryProvider.js
        content/data/anniversaries.js
    RESOURCES
        assets/quail.png
        assets/speak1.png
        assets/speak2.png
        assets/fonts/NotoSansJP-Variable.ttf
        assets/fonts/OFL.txt
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appdesktopPet PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appdesktopPet
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdesktopPet
    PRIVATE Qt6::Quick
)

install(TARGETS appdesktopPet
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
