#include "dllmain.h"

#include <basetsd.h>
#include <malloc.h>
#include <minwindef.h>
#include <windef.h>
#include <WinUser.h>

// ReSharper disable once CppInconsistentNaming
BOOL APIENTRY DllMain(HMODULE, DWORD, LPVOID) { return TRUE; }

EXPORT GM_DOUBLE win_display_count(void)
{
    return window_display_count;
}

EXPORT GM_DOUBLE win_display_get_default_monitor_index(void)
{
    return default_monitor_index;
}

EXPORT GM_DOUBLE win_display_get_height(const GM_DOUBLE window_index)
{
    if (window_index >= 0 && window_index < window_display_count)
        return displays[static_cast<int>(window_index)]->rcMonitor.bottom;

    return -1.0;
}

EXPORT GM_DOUBLE win_display_get_width(const GM_DOUBLE window_index)
{
    if (window_index >= 0 && window_index < window_display_count)
        return displays[static_cast<int>(window_index)]->rcMonitor.right;

    return -1.0;
}

EXPORT GM_DOUBLE win_display_get_x(const GM_DOUBLE window_index)
{
    if (window_index >= 0 && window_index < window_display_count)
        return displays[static_cast<int>(window_index)]->rcMonitor.left;

    return -1.0;
}

EXPORT GM_DOUBLE win_display_get_y(const GM_DOUBLE window_index)
{
    if (window_index >= 0 && window_index < window_display_count)
        return displays[static_cast<int>(window_index)]->rcMonitor.top;

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

EXPORT GM_DOUBLE win_vk_to_vsc(const GM_DOUBLE u_code)
{
    const HKL hkl = GetKeyboardLayout(0);
    return MapVirtualKeyExA(static_cast<UINT>(u_code), MAPVK_VK_TO_VSC, hkl);
}

EXPORT GM_DOUBLE win_vsc_to_vk(const GM_DOUBLE u_code)
{
    const HKL hkl = GetKeyboardLayout(0);
    return MapVirtualKeyExA(static_cast<UINT>(u_code), MAPVK_VSC_TO_VK, hkl);
}

EXPORT GM_DOUBLE win_window_set_popup(void* window_handle, const GM_DOUBLE toggle_popup)
{
    GM_DOUBLE success = GM_FALSE;

    if (window_handle)
    {
        LONG_PTR styles = GetWindowLongPtrW(static_cast<HWND>(window_handle), GWL_STYLE);

        if (toggle_popup) // NOLINT(bugprone-narrowing-conversions, clang-diagnostic-float-conversion, cppcoreguidelines-narrowing-conversions)
        {
            styles |= WS_POPUP;
        }
        else
        {
            styles &= ~WS_POPUP;
        }

        SetWindowLongPtrW(static_cast<HWND>(window_handle), GWL_STYLE, styles);
        success = GM_TRUE;
    }

    return success;
}

BOOL handle_enum_display_monitors(const HMONITOR monitor, HDC, LPRECT, LPARAM)
{
    if (window_display_count < 32 && GetMonitorInfoA(monitor, &display))
    {
        const auto info = static_cast<LPMONITORINFO>(malloc(sizeof(MONITORINFO)));

        if (!info)
            return FALSE;

        memcpy(info, &display, sizeof(MONITORINFO));

        displays[window_display_count] = info;

        if (info->rcMonitor.left == 0 && info->rcMonitor.top == 0)
            default_monitor_index = window_display_count;

        window_display_count++;
    }

    return TRUE;
}
