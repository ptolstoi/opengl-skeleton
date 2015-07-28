//
//  Application.cpp
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 28/07/15.
//
//

#include "Application.h"

#include <vector>

namespace lornar {
    
    Application::Application(const string &name)
    : m_name(name)
    , m_window(nullptr) {
        
        if(glfwInit() == GL_FALSE) {
            throw runtime_error("Could not initialize GLFW");
        }
        
        vector<const int> hint {
            GLFW_CONTEXT_VERSION_MAJOR, 3,
            GLFW_CONTEXT_VERSION_MINOR, 2,
            GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE,
            GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE,
            GLFW_DEPTH_BITS, 16, //no z-buffer required for system framebuffer
            GLFW_SAMPLES, 4, //Multisample anti aliasing samples
            GLFW_REFRESH_RATE, 60,
        };
        
        for (size_t h = 0; h < hint.size(); h += 2)
            glfwWindowHint(hint[h], hint[h+1]);
        
        m_window = glfwCreateWindow(640, 480, m_name.c_str(), nullptr, nullptr);
        
        if (!m_window) {
            throw runtime_error("OpenGL initialization failed, invalid window hints");
        }
        
        glfwMakeContextCurrent(m_window);
        
    }
    
    Application::~Application() {
        
        glfwTerminate();
        
    }
    
    void Application::run() {
        
        while (!glfwWindowShouldClose(m_window)) {
            glfwSwapBuffers(m_window);// Swap front and back buffers
            glfwPollEvents();       // Poll for and process events
        }
        
    }
    
}