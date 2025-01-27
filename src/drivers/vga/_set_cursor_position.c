#include <drivers/vga.h>

#include <stdint.h>

#include <core/io.h>

void _vga_set_cursor_position(uint16_t pos)
{
    // Ensure position is within bounds
    if (pos >= VGA_WIDTH * VGA_HEIGHT)
    {
        pos = (VGA_WIDTH * VGA_HEIGHT) - 1;
    }

    // Set high byte
    outb(VGA_CTRL_REGISTER, 14);
    outb(VGA_DATA_REGISTER, (pos >> 8) & 0xFF);

    // Set low byte
    outb(VGA_CTRL_REGISTER, 15);
    outb(VGA_DATA_REGISTER, pos & 0xFF);
}
