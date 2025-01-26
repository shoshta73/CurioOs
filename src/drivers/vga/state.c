#include <stddef.h>
#include <stdint.h>

// VGA text mode buffer
volatile uint16_t *vga_buffer = (volatile uint16_t *)0xB8000;
size_t vga_index = 0;
