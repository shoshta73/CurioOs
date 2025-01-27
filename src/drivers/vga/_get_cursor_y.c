#include <drivers/vga.h>

#include <stdint.h>

uint8_t _vga_get_cursor_y(uint16_t pos)
{
    return pos / VGA_WIDTH;
}
