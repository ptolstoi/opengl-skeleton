#
# setup flags for compiler
#

set(COMPILER_WITH_VERSION "${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}")

if(${CMAKE_CXX_COMPILER_ID} MATCHES ".*Clang")
    if(${CMAKE_CXX_COMPILER_ID} STREQUAL "AppleClang")
        check_cxx_version("6.1")
    elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
        check_cxx_version("3.6")
    else()
        message(FATAL_ERROR "unknown version of Clang: ${COMPILER_WITH_VERSION}")
    endif()

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -stdlib=libc++")

    if(APPLE)
        set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework AppKit")
    endif()
else()
    message(FATAL_ERROR "unknown compiler ${COMPILER_WITH_VERSION}")
endif()
