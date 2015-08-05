//
//  Application.h
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 28/07/15.
//
//

#pragma once

#include <string>

#include <GLFW/glfw3.h>

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
        
        bool m_on;
    };
}