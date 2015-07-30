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
    if($ENV{TRAVIS})
      # is already set
    else()
      set(CMAKE_C_COMPILER "/usr/bin/clang")
      set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
    endif()
elseif(WIN32)
    # we don't need nothing here
else()
    message(FATAL_ERROR "Platform not yet supported")
endif()
