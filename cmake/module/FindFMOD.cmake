find_path(FMOD_INCLUDE_PATH fmod.h PATH_SUFFIXES lib/fmod/include)

set(FMOD_NAMES ${FMOD_NAMES} fmod fmod64_vc.lib)
find_library(FMOD_LIBRARY
    HINTS lib
    NAMES ${FMOD_NAMES}
    PATH_SUFFIXES fmod
)

if(FMOD_LIBRARY AND FMOD_INCLUDE_PATH)
    set(FMOD_LIBRARIES ${FMOD_LIBRARY})
    set(FMOD_FOUND "YES")
else(FMOD_LIBRARY AND FMOD_INCLUDE_PATH)
    set(FMOD_FOUND "NO")
endif(FMOD_LIBRARY AND FMOD_INCLUDE_PATH)

if(FMOD_FOUND)
    if(NOT FMOD_FIND_QUIETLY)
        message(STATUS "Found FMOD: ${FMOD_LIBRARIES}")
    endif(NOT FMOD_FIND_QUIETLY)
else(FMOD_FOUND)
    if(FMOD_FIND_REQUIRED)
        message(FATAL_ERROR "Could not find FMOD library")
    endif(FMOD_FIND_REQUIRED)
endif(FMOD_FOUND)

# Deprecated declarations.
set(NATIVE_FMOD_INCLUDE_PATH ${FMOD_INCLUDE_PATH} )
get_filename_component(NATIVE_FMOD_LIB_PATH ${FMOD_LIBRARY} PATH)
