cmake_minimum_required(VERSION 3.5)
project(morph-tor-browser VERSION 1.1.0 LANGUAGES CXX)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

find_package(Gettext REQUIRED)

option(CLICK_MODE "Build as a click package" off)

# Standard install paths
include(GNUInstallDirs)

#set install paths
if(CLICK_MODE)
  set(CMAKE_INSTALL_PREFIX "/")
  set(CMAKE_INSTALL_BINDIR "/")
  set(CMAKE_INSTALL_FULL_DATADIR "./share")
  add_definitions("-DCLICK_MODE")
endif()

string(TOLOWER "${CMAKE_BUILD_TYPE}" cmake_build_type_lower)

include(EnableCoverageReport)
#####################################################################
# Enable code coverage calculation with gcov/gcovr/lcov
# Usage:
#  * Switch build type to coverage (use ccmake or cmake-gui)
#  * Invoke make, make test, make coverage (or ninja if you use that backend)
#  * Find html report in subdir coveragereport
#  * Find xml report feasible for jenkins in coverage.xml
#####################################################################
if(cmake_build_type_lower MATCHES coverage)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage" )
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --coverage" )
    set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} --coverage" )
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} --coverage" )
    ENABLE_COVERAGE_REPORT(EXCLUDES tests/*|.*moc_.*.cpp FILTER tests/* moc_*.cpp)
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# enable QML debugging
if(CMAKE_BUILD_TYPE MATCHES DEBUG OR CMAKE_BUILD_TYPE MATCHES "Debug")
    add_definitions(-DQT_QML_DEBUG)
endif()

include(qt5)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

set(DESKTOP_FILE morph-tor-browser.desktop)

# uninstall target
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)
add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

add_subdirectory(src)

enable_testing()
add_subdirectory(tests)

# make non compiled files (QML, JS, images, etc.) visible in QtCreator
file(GLOB NON_COMPILED_ROOT *.png .gitignore COPYING README snapcraft.yaml)
file(GLOB_RECURSE NON_COMPILED_SUBDIRS
     debian/*.dirs debian/*.install debian/*.lintian-overrides debian/*.manifest
     debian/compat debian/control debian/copyright debian/rules debian/source/format
     debian/tests/*
     doc/*.css doc/*.qdoc doc/*.qdocconf
     po/*.po po/*.pot
     snap/morph-tor-browser.launcher
     src/*.js src/*.qml src/*.sci src/README
     tests/*.py tests/*.qml)
add_custom_target(NON_COMPILED_TARGET ALL SOURCES ${NON_COMPILED_ROOT} ${NON_COMPILED_SUBDIRS})

set(GETTEXT_PACKAGE "morph-tor-browser")

add_subdirectory(po)

add_subdirectory(doc)

install(FILES morph-tor-browser.svg DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser)
install(FILES morph-tor-browser-splash.svg DESTINATION ${CMAKE_INSTALL_DATADIR}/morph-tor-browser)

install(FILES /usr/bin/tor
PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
DESTINATION ${CMAKE_INSTALL_DATADIR}/tor)

install(FILES src/tor/torrc
DESTINATION ${CMAKE_INSTALL_DATADIR}/tor)

add_subdirectory(click-hooks)
