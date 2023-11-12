#define YYSDK_PLUGIN

#include <Windows.h>
#include "main.h"

DllExport YYTKStatus PluginEntry(YYTKPlugin* pPlugin)
{
	pPlugin->PluginUnload = PluginUnload;

	PrintMessage(CLR_BLUE, "Sanity check!");
	return YYTK_OK;
}

DllExport YYTKStatus PluginUnload() { return YYTK_OK; }

BOOL APIENTRY DllMain(HMODULE, DWORD, LPVOID) { return TRUE; }
