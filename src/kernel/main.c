#include <kernel/state.h>
#include <kernel/io.h>

#include <drivers/vga.h>

void kernel_main()
{
    init_kernel_state();
    vga_init();
    set_kernel_display_mode(KDM_VGA);
    clear_screen();

    kprint("Kernel Entry Point Reached\n");
}
