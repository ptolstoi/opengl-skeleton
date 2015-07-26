cmake_minimum_required(VERSION 3.1)

#
# Project Meta Settings
#

set(APP_NAME "OpenGL Skeleton")
set(APP_EXECUTABLE_NAME "opengl-skeleton")
set(APP_PACKAGE_NAME "de.pault.opengl-skeleton")

set(APP_VERSION_MAJOR 1)
set(APP_VERSION_MINOR 0)
set(APP_VERSION_PATCH 0)
set(APP_VERSION_TWEAK 0)

set(APP_COPYRIGHT "Paul Tolstoi © 2015")

#
# Project Setup
#

project(${APP_NAME} VERSION "${APP_VERSION_MAJOR}.${APP_VERSION_MINOR}.${APP_VERSION_PATCH}.${APP_VERSION_TWEAK}")


#
# Includes
#

include("cmake/variables.cmake")
include("cmake/functions.cmake")

include("cmake/compiler.cmake")
include("cmake/executable.cmake")
