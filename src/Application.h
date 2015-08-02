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
        Application(const string &name);
        virtual ~Application();
        
        virtual void run();
        
    private:
        string m_name;
        GLFWwindow *m_window;
        
        bool m_on;
    };
}