#
# setup flags for compiler
#

if(${CMAKE_CXX_COMPILER_ID} MATCHES "AppleClang")
    check_cxx_version("6.1")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -stdlib=libc++")

    if(APPLE)
        set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
    endif()
else()
    message(WARNING "unknown compiler ${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}")
endif()
