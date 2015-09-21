//
//  pathhelper.hpp
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 20/09/15.
//
//

#pragma once

#include <string>
#include <memory>

#include <PlatformDefines.h>

#ifdef ENGINE_OSX
#include <mach-o/dyld.h>
#include <sys/param.h>
#elif defined(ENGINE_WINDOWS)
#include <Windows.h>
#elif defined(ENGINE_LINUX)
#include <unistd.h>
#endif

namespace lornar {
    using namespace std;
    
    /// returns application path without trailing slash
    unique_ptr<string> getApplicationPath();
    /// returs resources path without trailing slash
    unique_ptr<string> getResourcePath();
}