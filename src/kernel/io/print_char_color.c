#include <kernel/io.h>

#include <kernel/state.h>
#include <drivers/vga.h>

void _kprint_char_color(char c, uint8_t color)
{
    if (kernel_state.display_mode == KDM_VGA)
    {
        print_char_color(c, color);
        return;
    }
}
