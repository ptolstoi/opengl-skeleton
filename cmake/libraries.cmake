#
# glfw
#

set(GLFW_BUILD_EXAMPLES OFF)
set(GLFW_BUILD_TESTS OFF)
set(GLFW_BUILD_DOCS OFF)
set(GLFW_INSTALL OFF)

add_subdirectory("${APP_LIBRARIES}/glfw")

set(GLFW_INCLUDE_PATH "${APP_LIBRARIES}/glfw/include")
