#
# Helper variables
#

set(APP_ROOT_DIR "${PROJECT_SOURCE_DIR}")
set(APP_OUTPUT_DIR "${PROJECT_BINARY_DIR}/bin")

set(APP_SOURCES "${APP_ROOT_DIR}/src")
set(APP_LIBRARIES "${APP_ROOT_DIR}/lib")
set(APP_RESOURCES "${APP_ROOT_DIR}/res")

set(APP_MISC_FILES "")

#
# CMake variables
#

list(APPEND CMAKE_MODULE_PATH "${APP_ROOT_DIR}/cmake/module")
list(APPEND CMAKE_PREFIX_PATH "${APP_ROOT_DIR}")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${APP_OUTPUT_DIR}")

set(CMAKE_BUILD_TYPE Release)

#
# Platform / Generator dependent variables
#

if(APPLE)
    set(MACOSX_BUNDLE_INFO_STRING ${APP_VERSION_SHORT})

    set(MACOSX_BUNDLE_GUI_IDENTIFIER ${APP_PACKAGE_NAME})
    set(MACOSX_BUNDLE_LONG_VERSION_STRING ${APP_VERSION_LONG})
    set(MACOSX_BUNDLE_BUNDLE_NAME ${APP_NAME})
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING ${APP_VERSION_SHORT})
    set(MACOSX_BUNDLE_BUNDLE_VERSION ${APP_VERSION_LONG})
    set(MACOSX_BUNDLE_COPYRIGHT ${APP_COPYRIGHT})
elseif(UNIX)
    # no special variables needed yet
elseif(WIN32)
    # no special varivalbe needed yet
else()
    message(FATAL_ERROR "Platform not yet supported")
endif()

if(EMSCRIPTEN)
    set(APP_EXECUTABLE_NAME "${APP_EXECUTABLE_NAME}.html")
    set(CMAKE_EXECUTABLE_SUFFIX "")
endif()
