#pragma once

#ifdef __APPLE__
    const auto kPlatformName = "OS X";
#elif __unix__
    const auto kPlatformName = "Linux";
#elif _WIN32
    const auto kPlatformName = "Windows";
#else
    #error platform not defined
#endif
