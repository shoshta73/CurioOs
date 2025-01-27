#include <kernel/io.h>

#include <kernel/state.h>
#include <drivers/vga.h>

void _kprint_string(const char *str)
{
    while (*str)
    {
        _kprint_char(*str++);
    }
}
