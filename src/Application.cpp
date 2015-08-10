//
//  Application.cpp
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 28/07/15.
//
//

#include "Application.h"
#include "PlatformDefines.h"
#include "glmmath.h"

#include <vector>
#include <stdexcept>
#include <random>

using namespace glm;

namespace lornar {
    
    Application::Application()
    : m_window(nullptr)
    , m_on(false) { }
    
    void Application::init(const string &name) {
        if(glfwInit() == GL_FALSE) {
            throw runtime_error("Could not initialize GLFW");
        }
        
        vector<int> hint {
            GLFW_CONTEXT_VERSION_MAJOR, 3,
            GLFW_CONTEXT_VERSION_MINOR, 2,
            GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE,
            GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE,
            GLFW_DEPTH_BITS, 16,
            GLFW_SAMPLES, 4, 
            GLFW_REFRESH_RATE, 60,
        };
        
        for (size_t h = 0; h < hint.size(); h += 2)
            glfwWindowHint(hint[h], hint[h+1]);
        
        ivec2 size(640, 480);
        
        m_window = glfwCreateWindow(size.x, size.y, name.c_str(), nullptr, nullptr);
        
        if (!m_window) {
            throw runtime_error("OpenGL initialization failed, invalid window hints");
        }
        
        glfwMakeContextCurrent(m_window);
        
    }
    
    void Application::release() {
        
    }
    
    Application::~Application() {
        
        glfwTerminate();
        
    }
    
    void Application::run() {
        
#ifndef EMSCRIPTEN
        while (!glfwWindowShouldClose(m_window)) {
#else
            int w = 0, h = 0;
            glfwGetFramebufferSize(m_window, &w, &h);
            if (w == 0 || h == 0) {
                printf("setting canvas size");
                emscripten_set_canvas_size(640, 480);
            }
#endif
            if (m_on) {
                glClearColor(1, 0, 0, 1);
            } else {
                glClearColor(0, 0, 0, 1);
            }
            m_on = !m_on;
            
            glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
            glfwSwapBuffers(m_window);// Swap front and back buffers
            glfwPollEvents();       // Poll for and process events
#ifndef EMSCRIPTEN
        }
#endif
    }
    
}