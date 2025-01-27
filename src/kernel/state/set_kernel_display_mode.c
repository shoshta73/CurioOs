#include <kernel/state.h>

void set_kernel_display_mode(kdisplay_mode mode)
{
    kernel_state.display_mode = mode;
}
