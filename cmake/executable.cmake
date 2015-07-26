#
# Collecting all source files
#
file(GLOB_RECURSE APP_SOURCE_FILES "${APP_SOURCES}/*")

foreach(source_file ${APP_SOURCE_FILES})
    message("Source File: ${source_file}")
endforeach()

#
# Platform / Generator dependent setup
#

if(APPLE)
    list(APPEND APP_MISC_FILES res/icon.icns)

    set(MACOSX_BUNDLE_ICON_FILE icon.icns)
    set_source_files_properties(res/icon.icns
                                PROPERTIES
                                MACOSX_PACKAGE_LOCATION Resources)
elseif(UNIX)
    # nothing to do here, no logo for unix :(
elseif(WIN32)
    list(APPEND APP_MISC_FILES res/icon.ico res/icon.rc)
else()
    message(FATAL_ERROR "Platform not yet supported")
endif()

#
# Creating target
#

add_executable(${APP_EXECUTABLE_NAME} WIN32 MACOSX_BUNDLE ${APP_SOURCE_FILES} ${APP_MISC_FILES})

include_directories(${APP_SOURCES} ${APP_LIBRARIES})

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
else()
    message(FATAL_ERROR "Platform not yet supported")
endif()
