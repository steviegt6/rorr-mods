#include "main.h"
#include "hooking.h"

void Hook(void* to, void* from, void** orig, char* name)
{
	if (from)
	{
		if (MH_CreateHook())
	}
	else
	{
		PrintMessage(CLR_RED, "Could not hook function %s (null address)", name);
	}
}