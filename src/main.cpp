#include <iostream>
#include "main.h"

#ifdef _WIN32
#include <Windows.h>

int main(int, char*[]);
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE prevInstance, LPSTR lpCmdLine, int nShowCmd)
{
    return main(__argc, __argv);
}
#endif

int main(int argc, char *argv[]) {

    std::cout << "Hello World from " << kPlatformName << std::endl;

    return 0;
}
