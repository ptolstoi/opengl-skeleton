#
# glfw
#

set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "build glfw examples")
set(GLFW_BUILD_TESTS OFF CACHE BOOL "build glfw tests")
set(GLFW_BUILD_DOCS OFF CACHE BOOL "build glfw docs")
set(GLFW_INSTALL OFF CACHE BOOL "install glfw")

add_subdirectory("${APP_LIBRARIES}/glfw")

set(GLFW_INCLUDE_PATH "${APP_LIBRARIES}/glfw/include")
