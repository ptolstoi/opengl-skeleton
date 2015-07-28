//
//  PlatformDefines.h
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 28/07/15.
//
//

#pragma once

#ifdef __APPLE__

#define ENGINE_OSX

#elif __unix__

#define ENGINE_LINUX

#elif _WIN32

#define ENGINE_WINDOWS

#else
#error platform not defined
#endif