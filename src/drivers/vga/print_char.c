#include <drivers/vga.h>

#include <stddef.h>
#include <stdint.h>

void print_char_color(char c, uint8_t color)
{
    if (c == '\n')
    {
        _vga_set_cursor_xy(0, _vga_cursor.y + 1);
        return;
    }

    if (c == '\r')
    {
        _vga_set_cursor_xy(0, _vga_cursor.y);
        return;
    }

    vga_buffer[_vga_cursor_to_uint16(_vga_cursor)] = (color << 8) | c;
    _vga_set_cursor_xy(_vga_cursor.x + 1, _vga_cursor.y);
}

void print_char(char c)
{
    print_char_color(c, 0x0F);
}
