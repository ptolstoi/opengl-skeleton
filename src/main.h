#pragma once

#ifdef __APPLE__
    const auto kPlatformName = "OS X";
#else
    throw "platform not defined";
#endif
