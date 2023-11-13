#include "main.h"

DllExport YYTKStatus PluginEntry(YYTKPlugin* pPlugin)
{
	return YYTK_OK;
}

DllExport YYTKStatus PluginUnload()
{
	return YYTK_OK;
}

BOOL APIENTRY DllMain(HMODULE, DWORD, LPVOID) { return TRUE; }
