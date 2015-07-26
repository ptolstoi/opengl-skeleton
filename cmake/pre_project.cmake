#
# Helper variables for project setup
#

set(APP_VERSION_SHORT "${APP_VERSION_MAJOR}.${APP_VERSION_MINOR}")
set(APP_VERSION_LONG "${APP_VERSION_MAJOR}.${APP_VERSION_MINOR}.${APP_VERSION_PATCH}.${APP_VERSION_TWEAK}")

#
# Platform / Generator dependent variables
#

if(APPLE)
    # we don't need nothing here
elseif(UNIX)
    set(CMAKE_C_COMPILER "/usr/bin/clang")
    set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
else()
    message(WARNING "Platform not yet supported")
endif()
