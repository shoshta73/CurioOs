#include <drivers/vga.h>

#include <stddef.h>
#include <stdint.h>

void print_string_color(const char *str, uint8_t color)
{
    while (*str)
    {
        print_char_color(*str++, color);
    }
}

void print_string(const char *str)
{
    while (*str)
    {
        print_char(*str++);
    }
}
