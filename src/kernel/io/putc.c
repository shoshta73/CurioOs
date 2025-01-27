#include <kernel/io.h>

#include <kernel/state.h>
#include <drivers/vga.h>

void kputc(char c)
{
    _kprint_char(c);
}
