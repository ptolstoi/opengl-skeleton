//
//  PlatformDefines.h
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 26/07/15.
//
//

#include "main.h"
#include <iostream>

#ifdef ENGINE_WINDOWS
#include <Windows.h>

int main(int, char*[]);
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE prevInstance, LPSTR lpCmdLine, int nShowCmd)
{
    return main(__argc, __argv);
}
#endif

lornar::Application *app = nullptr;

void run() {
    if (app != nullptr) {
        app->run();
    }
}

int main(int argc, char *argv[]) {
    try {
        
        app = new lornar::Application("OpenGL Skeleton");
        
#ifndef EMSCRIPTEN
        app->run();
#else
        emscripten_set_main_loop(run, 0, 0);
#endif
        
    } catch (std::exception &e) {
        std::cout << "Exception: " << e.what() << std::endl;
    }
    
    if (app != nullptr) {
        delete app;
    }
    
    return 0;
}
