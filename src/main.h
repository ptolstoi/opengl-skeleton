#pragma once

#ifdef __APPLE__
    const auto kPlatformName = "OS X";
#elif __unix__
    const auto kPlatformName = "Linux";
#else
    throw "platform not defined";
#endif
