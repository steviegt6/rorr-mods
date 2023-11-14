#pragma once

// https://github.com/Archie-osu/YYToolkit/blob/stable/YYToolkit/Src/Core/Utils/Logging/Logging.hpp

enum console_color : int
{
    black = 0,
    dark_blue = 1,
    green = 2,
    aqua = 3,
    red = 4,
    purple = 5,
    gold = 6,
    light_gray = 7,
    gray = 8,
    blue = 9,
    matrix_green = 10,
    light_blue = 11,
    light_red = 12,
    bright_purple = 13,
    yellow = 14,
    white = 15,
};

void set_console_color(console_color color);
void msg(console_color color, const char* format, ...);
