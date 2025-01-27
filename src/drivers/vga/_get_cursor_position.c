#include <drivers/vga.h>

#include <stdint.h>

#include <core/io.h>

uint16_t _vga_get_cursor_position(void)
{
    uint16_t pos = 0;

    // Get high byte
    outb(VGA_CTRL_REGISTER, 14);
    pos = inb(VGA_DATA_REGISTER) << 8;

    // Get low byte
    outb(VGA_CTRL_REGISTER, 15);
    pos |= inb(VGA_DATA_REGISTER);

    return pos;
}
