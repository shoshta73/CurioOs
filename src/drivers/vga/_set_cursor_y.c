#include <drivers/vga.h>

#include <stdint.h>

void _vga_set_cursor_y(uint8_t y)
{
    if (y >= VGA_HEIGHT)
    {
        y = VGA_HEIGHT - 1;
    }

    _vga_cursor.y = y;

    uint16_t pos = _vga_cursor_to_uint16(_vga_cursor);
    _vga_set_cursor_position(pos);
}
