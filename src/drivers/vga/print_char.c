#include <drivers/vga.h>

#include <stddef.h>
#include <stdint.h>

void print_char_color(char c, uint8_t color)
{
    if (c == '\n')
    {
        vga_index = (vga_index + 80) - (vga_index % 80);
        return;
    }

    if (c == '\r')
    {
        vga_index = vga_index - (vga_index % 80);
        return;
    }

    vga_buffer[vga_index++] = (color << 8) | c;
}

void print_char(char c)
{
    print_char_color(c, 0x0F);
}
