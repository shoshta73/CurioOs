#include <drivers/vga.h>

#include <stdint.h>

uint16_t _vga_cursor_to_uint16(vga_cursor cursor)
{
    return (cursor.y * VGA_WIDTH + cursor.x);
}
