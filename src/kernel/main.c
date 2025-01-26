#ifndef KERNEL_H
#define KERNEL_H

#include <stddef.h>
#include <stdint.h>

// VGA text mode colors
#define VGA_COLOR_BLACK 0
#define VGA_COLOR_BLUE 1
#define VGA_COLOR_GREEN 2
#define VGA_COLOR_CYAN 3
#define VGA_COLOR_RED 4
#define VGA_COLOR_MAGENTA 5
#define VGA_COLOR_BROWN 6
#define VGA_COLOR_LIGHT_GRAY 7
#define VGA_COLOR_DARK_GRAY 8
#define VGA_COLOR_LIGHT_BLUE 9
#define VGA_COLOR_LIGHT_GREEN 10
#define VGA_COLOR_LIGHT_CYAN 11
#define VGA_COLOR_LIGHT_RED 12
#define VGA_COLOR_LIGHT_MAGENTA 13
#define VGA_COLOR_YELLOW 14
#define VGA_COLOR_WHITE 15

// Function prototypes
void clear_screen();
void print_char(char c, uint8_t color);
void print_string(const char *str, uint8_t color);
void kernel_main();

#endif // KERNEL_H

// VGA text mode buffer
volatile uint16_t *vga_buffer = (volatile uint16_t *)0xB8000;
size_t vga_index = 0;

void clear_screen()
{
    for (size_t i = 0; i < 80 * 25; i++)
    {
        vga_buffer[i] = 0;
    }
    vga_index = 0;
}

void print_char(char c, uint8_t color)
{
    if (c == '\n')
    {
        vga_index = (vga_index + 80) - (vga_index % 80);
        return;
    }

    vga_buffer[vga_index++] = (color << 8) | c;
}

void print_string(const char *str, uint8_t color)
{
    while (*str)
    {
        print_char(*str++, color);
    }
}

void kernel_main()
{
    // Clear screen
    clear_screen();

    // Print welcome message
    print_string("Welcome to Minimal OS!", 0x0F);
}
