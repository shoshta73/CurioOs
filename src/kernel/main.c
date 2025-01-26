#include <drivers/vga.h>

void kernel_main()
{
    clear_screen();
    print_string("Kernel Entry Point Reached\n");
}
