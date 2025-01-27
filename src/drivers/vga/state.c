#include <drivers/vga.h>

#include <stddef.h>
#include <stdint.h>

// VGA text mode buffer
volatile uint16_t *vga_buffer = (volatile uint16_t *)0xB8000;
vga_cursor _vga_cursor = {0, 0};
