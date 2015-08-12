//
//  opengl.h
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 10/08/15.
//
//

#pragma once

#include "PlatformDefines.h"

#ifndef EMSCRIPTEN
#include <GL/gl3w.h>
#else
#define GL_GLEXT_PROTOTYPES
#include <GL/gl.h>
#include <GL/glext.h>
#endif

#include <GLFW/glfw3.h>