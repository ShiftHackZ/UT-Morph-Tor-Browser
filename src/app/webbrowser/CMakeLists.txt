project(morph-tor-browser)

find_package(Qt5Concurrent REQUIRED)
find_package(Qt5Sql REQUIRED)

set(THREADS_PTHREAD_ARG "2" CACHE STRING "Forcibly set by CMakeLists.txt." FORCE)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

include_directories(
    ${CMAKE_BINARY_DIR}
    ${webbrowser-common_SOURCE_DIR}
    ${webbrowser-common_BINARY_DIR}
)

set(WEBBROWSER_APP_MODELS_SRC
    bookmarks-model.cpp
    bookmarks-folder-model.cpp
    bookmarks-folderlist-model.cpp
    history-domain-model.cpp
    history-domainlist-model.cpp
    history-lastvisitdatelist-model.cpp
    history-model.cpp
    limit-proxy-model.cpp
    tabs-model.cpp
    text-search-filter-model.cpp
)

set(WEBBROWSER_APP_MODELS morph-tor-browser-models)

add_library(${WEBBROWSER_APP_MODELS} STATIC ${WEBBROWSER_APP_MODELS_SRC})
target_link_libraries(${WEBBROWSER_APP_MODELS}
    Qt5::Core
    Qt5::Sql
    Threads::Threads
#    Qt5::WebEngine
)

set(WEBBROWSER_APP_SRC
    reparenter.cpp
    searchengine.cpp
    morph-tor-browser.cpp
)

set(WEBBROWSER_APP morph-tor-browser)

add_executable(${WEBBROWSER_APP} ${WEBBROWSER_APP_SRC})
target_link_libraries(${WEBBROWSER_APP}
    Qt5::Concurrent
    Qt5::Core
    Qt5::Qml
    Qt5::Quick
    ${COMMONLIB}
    ${WEBBROWSER_APP_MODELS}
)

install(TARGETS ${WEBBROWSER_APP}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

file(GLOB QML_FILES *.qml qmldir *.js)
install(FILES ${QML_FILES} DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser/webbrowser)

install(DIRECTORY assets
        DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser/webbrowser
        FILES_MATCHING PATTERN *.png PATTERN *.svg PATTERN *.sci)

install(DIRECTORY searchengines
        DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser/webbrowser
        FILES_MATCHING PATTERN *.xml)

configure_file(${DESKTOP_FILE}.in.in ${DESKTOP_FILE}.in @ONLY)
add_custom_target(${DESKTOP_FILE} ALL
    COMMENT "Merging translations into ${DESKTOP_FILE}"
    COMMAND ${GETTEXT_MSGFMT_EXECUTABLE}
            --desktop --template=${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE}.in
            -o ${DESKTOP_FILE}
            -d ${CMAKE_SOURCE_DIR}/po
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE}
        DESTINATION ${CMAKE_INSTALL_DATADIR}/applications)

install(FILES "morph-tor-browser.url-dispatcher"
        DESTINATION ${CMAKE_INSTALL_DATADIR}/lomiri-url-dispatcher/urls)

install(FILES "morph-tor-browser-content-hub.json"
    DESTINATION ${CMAKE_INSTALL_DATADIR}/content-hub/peers
    RENAME morph-tor-browser
    )

if(${CLICK_MODE})
  message("-- Configuring manifest.json")

  execute_process(
    COMMAND dpkg-architecture -qDEB_HOST_ARCH
    OUTPUT_VARIABLE CLICK_ARCH
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  configure_file(manifest.json.in ${CMAKE_CURRENT_BINARY_DIR}/manifest.json)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/manifest.json DESTINATION ${CMAKE_INSTALL_PREFIX})
  install(FILES morph-tor-browser.apparmor DESTINATION ${CMAKE_INSTALL_PREFIX})
endif()
