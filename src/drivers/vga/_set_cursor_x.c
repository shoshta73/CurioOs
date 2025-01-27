#include <drivers/vga.h>

#include <stdint.h>

void _vga_set_cursor_x(uint8_t x)
{
    if (x >= VGA_WIDTH)
    {
        x = VGA_WIDTH - 1;
    }

    _vga_cursor.x = x;

    uint16_t pos = _vga_cursor_to_uint16(_vga_cursor);
    _vga_set_cursor_position(pos);
}
