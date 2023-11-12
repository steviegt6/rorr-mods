#include "dllmain.h"
#include <malloc.h>
#include <WinUser.h>
#include <minwindef.h>
#include <windef.h>
#include <basetsd.h>

BOOL APIENTRY DllMain(HMODULE, DWORD, LPVOID) { return TRUE; }

EXPORT GM_DOUBLE win_display_count(void)
{
	return (GM_DOUBLE)window_display_count;
}

EXPORT GM_DOUBLE win_display_get_default_monitor_index(void)
{
	return (GM_DOUBLE)default_monitor_index;
}

EXPORT GM_DOUBLE win_display_get_height(GM_DOUBLE windowIndex)
{
	if (windowIndex >= 0 && windowIndex < window_display_count)
		return displays[(int)windowIndex]->rcMonitor.bottom;

	return -1.0;
}

EXPORT GM_DOUBLE win_display_get_width(GM_DOUBLE windowIndex)
{
	if (windowIndex >= 0 && windowIndex < window_display_count)
		return displays[(int)windowIndex]->rcMonitor.right;

	return -1.0;
}

EXPORT GM_DOUBLE win_display_get_x(GM_DOUBLE windowIndex)
{
	if (windowIndex >= 0 && windowIndex < window_display_count)
		return displays[(int)windowIndex]->rcMonitor.left;

	return -1.0;
}

EXPORT GM_DOUBLE win_display_get_y(GM_DOUBLE windowIndex)
{
	if (windowIndex >= 0 && windowIndex < window_display_count)
		return displays[(int)windowIndex]->rcMonitor.top;

	return -1.0;
}

EXPORT GM_DOUBLE win_display_update_cache(void)
{
	for (int i = 0; i < window_display_count; i++)
	{
		free(displays[i]);
		displays[i] = {};
	}

	// Set cbSize before handle_enum_display_monitors since it uses this as
	// input and the size controls whether it fills MONITORINFO or
	// MONITORINFOEX.
	display.cbSize = sizeof(MONITORINFO); // 40 bytes, 0x28
	window_display_count = 0;
	default_monitor_index = 0;

	EnumDisplayMonitors(nullptr, nullptr, handle_enum_display_monitors, 0);

	return GM_TRUE;
}

EXPORT GM_STRING win_get_keyboard_layout_name(void)
{
	GetKeyboardLayoutNameA(keyboard_layout_name);
	return keyboard_layout_name;
}

EXPORT GM_DOUBLE win_vk_to_vsc(GM_DOUBLE uCode)
{
	HKL hkl = GetKeyboardLayout(0);
	return (GM_DOUBLE)MapVirtualKeyExA((UINT)uCode, MAPVK_VK_TO_VSC, hkl);
}

EXPORT GM_DOUBLE win_vsc_to_vk(GM_DOUBLE uCode)
{
	HKL hkl = GetKeyboardLayout(0);
	return (GM_DOUBLE)MapVirtualKeyExA((UINT)uCode, MAPVK_VSC_TO_VK, hkl);
}

// Parameter is a GM_STRING but is really just a pointer.
EXPORT GM_DOUBLE win_window_set_popup(GM_STRING windowHandle, GM_DOUBLE togglePopup)
{
	GM_DOUBLE success = GM_FALSE;
	LONG_PTR styles;
	
	if (windowHandle)
	{
		styles = GetWindowLongPtrW((HWND)windowHandle, GWL_STYLE);

		if (!togglePopup)
		{
			styles &= ~WS_POPUP;
		}
		else
		{
			styles |= WS_POPUP;
		}

		SetWindowLongPtrW((HWND)windowHandle, GWL_STYLE, styles);
		success = GM_TRUE;
	}

	return success;
}

BOOL handle_enum_display_monitors(HMONITOR hMonitor, HDC, LPRECT, LPARAM)
{
	if (window_display_count < 32 && GetMonitorInfoA(hMonitor, &display))
	{
		LPMONITORINFO info = (LPMONITORINFO)malloc(sizeof(MONITORINFO));

		if (!info)
			return FALSE;

		memcpy(info, &display, sizeof(MONITORINFO));

		displays[window_display_count] = info;

		if (info->rcMonitor.left == 0 && info->rcMonitor.top== 0)
			default_monitor_index = window_display_count;

		window_display_count++;
	}

	return TRUE;
}
