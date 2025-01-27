#include <kernel/io.h>

#include <kernel/state.h>
#include <drivers/vga.h>

void kprint(const char *str)
{
    _kprint_string(str);
}
