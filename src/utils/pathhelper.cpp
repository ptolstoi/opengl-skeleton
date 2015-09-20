//
//  pathhelper.cpp
//  OpenGL Skeleton
//
//  Created by Paul Tolstoi on 20/09/15.
//
//

#include "pathhelper.h"

namespace lornar {
    unique_ptr<string> getApplicationPath() {
        string * result = nullptr;

#ifdef ENGINE_OSX
        int ret;
        char executablePath[MAXPATHLEN];
        uint32_t size = sizeof(executablePath);

        ret = _NSGetExecutablePath(executablePath, &size);
        if (ret < 0) {
            throw "getting executable path failed";
        } else {
            string exePathString(executablePath);
            
            // removing executable name
            exePathString = exePathString.substr(0, exePathString.find_last_of('/'));
            
            // removing MacOS subfolder
            exePathString = exePathString.substr(0, exePathString.find_last_of('/'));
            
            result = new string(exePathString);
        }
#elif ENGINE_WINDOWS
        HMODULE hModule = GetModuleHandleW(NULL);
        WCHAR exe_fullpath[MAX_PATH];
        GetModuleFileNameW(hModule, exe_fullpath, MAX_PATH);
        
        // remove file name
        wstring ws_exe_path(exe_fullpath);
        ws_exe_path = ws_exe_path.substr(0, ws_exe_path.find_last_of('\\'));
        result = new string(ws_exe_path.begin(), ws_exe_path.end());
#elif ENGINE_LINUX
        char buf[1024];
        ssize_t len = readlink("/proc/self/exe", buf, sizeof(buf)-1);
        if (len == -1) {
            throw "getting executable path failed";
        }
        buf[len] = '\0';
        
        string path = buf;
        path = path.substr(0, path.find_last_of('/'));
        result = new string(path);
#else
#error platform not defined
#endif
        
        return unique_ptr<string>(result);
    }
    
    unique_ptr<string> getResourcePath() {
        auto applicationPath = getApplicationPath();
        auto fullPath = *applicationPath.get();
        
        string * result = nullptr;
#ifdef ENGINE_OSX
        result = new string(fullPath + "/Resources");
#elif ENGINE_WINDOWS
        result = new string(fullPath);
#elif ENGINE_LINUX
        result = new string(fullPath);
#else
#error platform not defined
#endif
        
        return unique_ptr<string>(result);
    }
}