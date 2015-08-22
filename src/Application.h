//
//  Application.h
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 28/07/15.
//
//

#pragma once

#include <string>

#include "opengl.h"
#ifndef EMSCRIPTEN
#include <fmod.hpp>
#include <fmod_errors.h>
#else
extern "C" {
    extern void audioInit();
    extern void audioUpdate();
}
#endif

namespace lornar {
    
    using namespace std;
    
    class Application {
    public:
        Application();
        virtual ~Application();
        
        void init(const string &name);
        void release();
        
        virtual void run();
        
    private:
        GLFWwindow *m_window;

#ifndef EMSCRIPTEN
        FMOD::System *m_audio;
        inline void checkError(FMOD_RESULT);
#endif
        
        bool m_on;
    };
}