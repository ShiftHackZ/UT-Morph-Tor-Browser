find_package(Qt5Core REQUIRED)
find_package(Qt5Sql REQUIRED)
find_package(Qt5Test REQUIRED)
set(TEST tst_HistoryModelTests)
add_executable(${TEST} tst_HistoryModelTests.cpp)
include_directories(${morph-tor-browser_SOURCE_DIR})
target_link_libraries(${TEST}
    Qt5::Core
    Qt5::Sql
    Qt5::Test
    morph-tor-browser-models
)
add_test(${TEST} ${CMAKE_CURRENT_BINARY_DIR}/${TEST})
