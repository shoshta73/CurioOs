#include <drivers/vga.h>

#include <stddef.h>
#include <stdint.h>

void clear_screen()
{
    for (uint8_t y = 0; y < VGA_HEIGHT; y++)
    {
        for (uint8_t x = 0; x < VGA_WIDTH; x++)
        {
            vga_buffer[y * VGA_WIDTH + x] = 0;
        }
    }

    _vga_set_cursor_xy(0, 0);
}
