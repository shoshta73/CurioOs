#include <kernel/io.h>

#include <kernel/state.h>
#include <drivers/vga.h>

void _kprint_string_color(const char *str, uint8_t color)
{
    while (str)
    {
        _kprint_char_color(*str, color);
        str++;
    }
}
