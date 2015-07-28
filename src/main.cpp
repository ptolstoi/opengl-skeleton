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

int main(int argc, char *argv[]) {

    try {
        
        auto app = lornar::Application("OpenGL Skeleton");
    
        app.run();
        
    } catch (std::exception &e) {
        std::cout << "Exception: " << e.what() << std::endl;
    }
    
    return 0;
}
