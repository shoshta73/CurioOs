#ifndef __CURIO_OS_DRIVERS_VGA_H__
#define __CURIO_OS_DRIVERS_VGA_H__ 1

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

extern volatile uint16_t *vga_buffer;
extern size_t vga_index;

void clear_screen();
void print_char_color(char c, uint8_t color);
void print_char(char c);
void print_string_color(const char *str, uint8_t color);
void print_string(const char *str);

#endif // __CURIO_OS_DRIVERS_VGA_H__
