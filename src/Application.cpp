//
//  Application.cpp
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 28/07/15.
//
//

#include "Application.h"
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
        
#ifndef EMSCRIPTEN
        if(gl3wInit()) {
            throw runtime_error("failed to initialize gl3w");
        }
#endif
        
        // shader test
        auto handleVertex = glCreateShader(GL_VERTEX_SHADER);
        auto handleFragment = glCreateShader(GL_FRAGMENT_SHADER);
        
        string sourceVertexStr = "#version 150\n in vec3 a_pos; void main() { }";
        string sourceFragmentStr = "#version 150\n in vec3 a_pos; out vec4 o_fragColor; void main() { o_fragColor = vec4(1, 0, 1, 1); }";
        
        const GLchar *sv = sourceVertexStr.c_str();
        const GLchar *sf = sourceVertexStr.c_str();

        auto check = [](GLuint handle) {
            GLint status;
            glGetShaderiv(handle, GL_COMPILE_STATUS, &status);
            if (status == GL_FALSE) {
                GLint logLength;
                glGetShaderiv(handle, GL_INFO_LOG_LENGTH, &logLength);
                
                GLchar *logStr = new GLchar[logLength + 1];
                glGetShaderInfoLog(handle, logLength, nullptr, logStr);
                
                fprintf(stderr, "Shader compiler error:\n%s\n", logStr);
                delete[] logStr;
            }
        };
        
        glShaderSource(handleVertex, 1, &sv, nullptr);
        glShaderSource(handleFragment, 1, &sf, nullptr);
        
        glCompileShader(handleVertex);
        check(handleVertex);
        glCompileShader(handleFragment);
        check(handleFragment);
        
        GLint status;
        
        auto handleProgram = glCreateProgram();
        
        glAttachShader(handleProgram, handleVertex);
        glAttachShader(handleProgram, handleFragment);
        
        glLinkProgram(handleProgram);
    
        glGetProgramiv(handleProgram, GL_LINK_STATUS, &status);
        
        if (status == GL_FALSE) {
            GLint logLength;
            glGetProgramiv(handleProgram, GL_INFO_LOG_LENGTH, &logLength);
            
            GLchar *logStr = new GLchar[logLength + 1];
            glGetProgramInfoLog(handleProgram, logLength, nullptr, logStr);
            
            fprintf(stderr, "Linker error:\n%s\n", logStr);
            delete[] logStr;
            return;
        }
        
        glDetachShader(handleProgram, handleVertex);
        glDetachShader(handleProgram, handleFragment);
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