#include <kernel/io.h>

#include <kernel/state.h>
#include <drivers/vga.h>

void _kprint_char(char c)
{
    if (kernel_state.display_mode == KDM_VGA)
    {
        _kprint_char_color(c, 0x0F);
        return;
    }
}
