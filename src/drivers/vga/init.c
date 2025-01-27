#include <drivers/vga.h>

#include <stdint.h>

#include <core/io.h>

void _vga_enable_cursor(void)
{
    outb(VGA_CTRL_REGISTER, 0x0A);
    outb(VGA_DATA_REGISTER, (inb(VGA_DATA_REGISTER) & 0xC0) | 0);

    outb(VGA_CTRL_REGISTER, 0x0B);
    outb(VGA_DATA_REGISTER, (inb(VGA_DATA_REGISTER) & 0xE0) | 15);
}

void vga_init()
{
    _vga_enable_cursor();

    uint16_t pos = _vga_get_cursor_position();
    _vga_cursor.x = _vga_get_cursor_x(pos);
    _vga_cursor.y = _vga_get_cursor_y(pos);
}
