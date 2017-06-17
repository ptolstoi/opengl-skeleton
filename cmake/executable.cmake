#
# Collecting all source files
#
file(GLOB_RECURSE APP_SOURCE_FILES "${APP_SOURCES}/*")

foreach(file ${FMOD_LIBRARIES})
    list(APPEND APP_SOURCE_FILES ${file})

    if(APPLE)
        set_source_files_properties(${file}
                                    PROPERTIES
                                    MACOSX_PACKAGE_LOCATION
                                    Frameworks)
    endif()
endforeach()

foreach(source_file ${APP_SOURCE_FILES})
    message("Source File: ${source_file}")

    if(EMSCRIPTEN)
        if(source_file MATCHES \.h$ OR source_file MATCHES \.hpp$)
            list(REMOVE_ITEM APP_SOURCE_FILES source_file)
        elseif(source_file MATCHES \.js$)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --js-library ${source_file}")
        endif()
    endif()
endforeach()

source_group(javascript REGULAR_EXPRESSION ".*\.js")

#
# Collecting all resources files
#

file(GLOB_RECURSE APP_RESOURCE_FILES "${APP_ROOT_DIR}/res/*")

foreach(file ${APP_RESOURCE_FILES})
    if(file MATCHES /shader/)
        list(APPEND APP_SHADER_FILES ${file})
        message("Shader File: ${file}")
    elseif(file MATCHES /sound/)
        list(APPEND APP_SOUND_FILES ${file})
        message("Sound File: ${file}")
    elseif(file MATCHES /texture/)
        list(APPEND APP_TEXTURE_FILES ${file})
        message("Texture File: ${file}")
    else()
        list(APPEND APP_MISC_FILES ${file})
        message("Other Resource File: ${file}")
    endif()
endforeach()

source_group("Resources\\shader" FILES ${APP_SHADER_FILES})
source_group("Resources\\sound" FILES ${APP_SOUND_FILES})
source_group("Resources\\texture" FILES ${APP_TEXTURE_FILES})
source_group("Resources\\misc" FILES ${APP_MISC_FILES})

ADD_CUSTOM_COMMAND(
   OUTPUT OUTPUT_OF_MY_CONTENT_GEN
   COMMAND MY_CONTENT_GEN ${CMAKE_CURRENT_SOURCE_DIR}/someinput.h ${APP_SOURCES}/gen/someoutput.h
   DEPENDS MY_CONTENT_GEN ${CMAKE_CURRENT_SOURCE_DIR}/someinput.h
   COMMENT running gen
)

list(APPEND ${APP_SOURCES} "${APP_SOURCES}/gen/someoutput.h")

add_custom_target(content_gen ALL DEPENDS OUTPUT_OF_MY_CONTENT_GEN)

#
# Platform / Generator dependent setup
#

if(APPLE)
    list(APPEND APP_MISC_FILES res/icon.icns)

    set(MACOSX_BUNDLE_ICON_FILE icon.icns)
    set_source_files_properties(res/icon.icns
                                PROPERTIES
                                MACOSX_PACKAGE_LOCATION Resources)


    set_macosx_package_location("${APP_ROOT_DIR}/res" "")

    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.10")
elseif(UNIX)
    copy_files("${APP_ROOT_DIR}/res" "${APP_OUTPUT_DIR}")
elseif(WIN32)
    list(APPEND APP_MISC_FILES res/icon.ico res/icon.rc)

    copy_files("${APP_ROOT_DIR}/res" "${APP_OUTPUT_DIR}")
else()
    message(FATAL_ERROR "Platform not yet supported")
endif()

#
# Libraries
#

set(APP_LINK_LIBRARIES glfw ${GLFW_LIBRARIES} glm gl3w ${FMOD_LIBRARY})

#
# Creating target
#

add_executable(${APP_EXECUTABLE_NAME} WIN32 MACOSX_BUNDLE ${APP_SOURCE_FILES} ${APP_MISC_FILES} ${APP_RESOURCE_FILES})

include_directories(${APP_SOURCES}
                    ${APP_LIBRARIES}
                    ${GLFW_INCLUDE_PATH}
                    ${GL3W_INCLUDE_PATH}
                    ${GLM_INCLUDE_PATH}
                    ${FMOD_INCLUDE_PATH})

target_link_libraries(${APP_EXECUTABLE_NAME} ${APP_LINK_LIBRARIES})

install(TARGETS ${APP_EXECUTABLE_NAME} DESTINATION bin)

#
# Fixes after target is created
#

if(APPLE)
    set_target_properties(${APP_EXECUTABLE_NAME} PROPERTIES XCODE_ATTRIBUTE_LD_RUNPATH_SEARCH_PATHS "@loader_path/../Frameworks")
elseif(UNIX)
    # nothing to do here, on unix nothing needs to be fixed (yet)
elseif(WIN32)
    set_target_properties( ${APP_EXECUTABLE_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${APP_OUTPUT_DIR} )
    foreach(config ${CMAKE_CONFIGURATION_TYPES})
        string(TOUPPER ${config} config_upper)
        set_target_properties( ${APP_EXECUTABLE_NAME} PROPERTIES "RUNTIME_OUTPUT_DIRECTORY_${config_upper}" ${APP_OUTPUT_DIR} )
    endforeach()

    add_custom_command(TARGET ${APP_EXECUTABLE_NAME}
		                   COMMAND ${CMAKE_COMMAND}
			                  -DMSVC_BUILD_CONFIG_DIR=${CMAKE_CFG_INTDIR}
			                  -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
			                  -DPROJECT_SOURCE_DIR=${PROJECT_SOURCE_DIR}
			                  -P "${PROJECT_SOURCE_DIR}/cmake/scripts/copydlls.cmake"
		VERBATIM
	)
else()
    message(FATAL_ERROR "Platform not yet supported")
endif()
