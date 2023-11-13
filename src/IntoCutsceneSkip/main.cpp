#define YYSDK_PLUGIN

#include <Windows.h>
#include "main.h"

static CallbackAttributes_t* p_gml_Object_oCutscenePlayback1_Create_0 = nullptr;

DllExport YYTKStatus PluginEntry(YYTKPlugin* pPlugin)
{
	pPlugin->PluginUnload = PluginUnload;

	PluginAttributes_t* pAttributes = nullptr;
	PmGetPluginAttributes(pPlugin, pAttributes);


	if (PmCreateCallback(pAttributes, p_gml_Object_oCutscenePlayback1_Create_0, ))

	return YYTK_OK;
}

DllExport YYTKStatus PluginUnload()
{
	PmRemoveCallback(p_gml_Object_oCutscenePlayback1_Create_0);

	return YYTK_OK;
}

BOOL APIENTRY DllMain(HMODULE, DWORD, LPVOID) { return TRUE; }
