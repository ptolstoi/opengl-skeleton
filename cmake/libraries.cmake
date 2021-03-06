#
# glfw
#

if(NOT EMSCRIPTEN)
    set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "build glfw examples")
    set(GLFW_BUILD_TESTS OFF CACHE BOOL "build glfw tests")
    set(GLFW_BUILD_DOCS OFF CACHE BOOL "build glfw docs")
    set(GLFW_INSTALL OFF CACHE BOOL "install glfw")

    add_subdirectory("${APP_LIBRARIES}/glfw")

    set(GLFW_INCLUDE_PATH "${APP_LIBRARIES}/glfw/include")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_GLFW=3")
endif()

#
# gl3w
#
if(NOT EMSCRIPTEN)
    add_subdirectory("${APP_LIBRARIES}/gl3w")

    set(GL3W_INCLUDE_PATH "${APP_LIBRARIES}/gl3w/include")
endif()

#
# glm
#

add_subdirectory("${APP_LIBRARIES}/glm")

set(GLM_INCLUDE_PATH "${APP_LIBRARIES}/glm/glm")

#
# fmod
#

if(NOT EMSCRIPTEN)
    find_package(FMOD REQUIRED)
endif()
