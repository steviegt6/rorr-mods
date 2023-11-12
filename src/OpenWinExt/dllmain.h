#pragma once

#include <Windows.h>

BOOL APIENTRY DllMain(HMODULE, DWORD, LPVOID);

#define EXPORT extern "C" __declspec(dllexport)
#define GM_DOUBLE double
#define GM_STRING char*
#define GM_FALSE 0.0
#define GM_TRUE 1.0

static int window_display_count;
static int default_monitor_index;
static LPMONITORINFO displays[32];
static MONITORINFO display{};
static CHAR keyboard_layout_name[KL_NAMELENGTH];

EXPORT GM_DOUBLE win_display_count(void);
EXPORT GM_DOUBLE win_display_get_default_monitor_index(void);
EXPORT GM_DOUBLE win_display_get_height(GM_DOUBLE windowIndex);
EXPORT GM_DOUBLE win_display_get_width(GM_DOUBLE windowIndex);
EXPORT GM_DOUBLE win_display_get_x(GM_DOUBLE windowIndex);
EXPORT GM_DOUBLE win_display_get_y(GM_DOUBLE windowIndex);
EXPORT GM_DOUBLE win_display_update_cache(void);
EXPORT GM_STRING win_get_keyboard_layout_name(void);
EXPORT GM_DOUBLE win_vk_to_vsc(GM_DOUBLE uCode);
EXPORT GM_DOUBLE win_vsc_to_vk(GM_DOUBLE uCode);
EXPORT GM_DOUBLE win_window_set_popup(GM_STRING p1, GM_DOUBLE p2);

BOOL handle_enum_display_monitors(HMONITOR hMonitor, HDC, LPRECT, LPARAM);
