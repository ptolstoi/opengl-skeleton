#
# setup flags for compiler
#

set(COMPILER_WITH_VERSION "${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}")

if(${CMAKE_CXX_COMPILER_ID} MATCHES ".*Clang")
    if(${CMAKE_CXX_COMPILER_ID} STREQUAL "AppleClang")
        check_cxx_version("6.1")
    elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
        if(${EMSCRIPTEN})
            add_definitions(-DEMSCRIPTEN)
        else()
            check_cxx_version("3.6")
        endif()
    else()
        message(FATAL_ERROR "unknown version of Clang: ${COMPILER_WITH_VERSION}")
    endif()

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -Wall -Wextra -Werror -Wfloat-equal -Wno-unused-parameter -Wno-unknown-pragmas -Wno-deprecated-declarations")

    if($ENV{TRAVIS})
      message("Hi, Travis CI!")
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++14")
    else()
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
    endif()

    if(APPLE)
        set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework AppKit")
    endif()
elseif(MSVC)
    check_cxx_version("19.0")
else()
    message("--${CMAKE_CXX_COMPILER_ID}--")
    message(FATAL_ERROR "unknown compiler ${COMPILER_WITH_VERSION}")
endif()
