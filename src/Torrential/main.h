#pragma once

#define YYSDK_PLUGIN
#include <SDK.hpp>;

DllExport YYTKStatus PluginEntry(YYTKPlugin* pPlugin);
DllExport YYTKStatus PluginUnload();
