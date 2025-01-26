#include <drivers/vga.h>

#include <stddef.h>
#include <stdint.h>

void clear_screen()
{
    for (size_t i = 0; i < 80 * 25; i++)
    {
        vga_buffer[i] = 0;
    }
    vga_index = 0;
}
