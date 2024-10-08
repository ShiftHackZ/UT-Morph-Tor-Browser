project(webapp-container)

find_package(Qt5DBus REQUIRED)
find_package(Qt5Sql REQUIRED)

include_directories(
    ${CMAKE_BINARY_DIR}
    ${webbrowser-common_SOURCE_DIR}
    ${webbrowser-common_BINARY_DIR}
)

set(WEBAPP_CONTAINER webapp-container)

set(WEBAPP_CONTAINER_SRC
    chrome-cookie-store.cpp
    cookie-store.cpp
    online-accounts-cookie-store.cpp
    oxide-cookie-helper.cpp
    local-cookie-store.cpp
    webapp-container.cpp
    webapp-container-helper.cpp
    session-utils.cpp
    url-pattern-utils.cpp
    scheme-filter.cpp
    intent-parser.cpp
)

add_executable(${WEBAPP_CONTAINER} ${WEBAPP_CONTAINER_SRC})

target_link_libraries(${WEBAPP_CONTAINER}
    Qt5::Core
    Qt5::DBus
    Qt5::Gui
    Qt5::Qml
    Qt5::Quick
    Qt5::Sql
    ${COMMONLIB}
)

install(TARGETS ${WEBAPP_CONTAINER}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

file(GLOB QML_FILES *.qml *.js)
install(FILES ${QML_FILES} DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser/webcontainer)
install(DIRECTORY actions DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser/webcontainer
        FILES_MATCHING PATTERN *.qml)

install(DIRECTORY assets
        DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser/webcontainer
        FILES_MATCHING PATTERN *.png)
