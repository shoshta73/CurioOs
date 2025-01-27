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

// VGA ports
#define VGA_CTRL_REGISTER 0x3D4
#define VGA_DATA_REGISTER 0x3D5

// Screen dimensions
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

extern volatile uint16_t *vga_buffer;

typedef struct vga_cursor_t
{
    uint8_t x;
    uint8_t y;
} vga_cursor;

uint16_t _vga_cursor_to_uint16(vga_cursor cursor);
// Set cursor position using x,y coordinates
void _vga_set_cursor_xy(uint8_t x, uint8_t y);
void _vga_set_cursor_x(uint8_t x);
void _vga_set_cursor_y(uint8_t y);

extern vga_cursor _vga_cursor;

void clear_screen();
void print_char_color(char c, uint8_t color);
void print_char(char c);

void vga_init();

// Get cursor X position
uint8_t _vga_get_cursor_x(uint16_t pos);

// Get cursor Y position
uint8_t _vga_get_cursor_y(uint16_t pos);

// Get cursor position (returns position as offset from start of video memory)
uint16_t _vga_get_cursor_position(void);

// Set cursor position using offset from start of video memory
void _vga_set_cursor_position(uint16_t pos);

#endif // __CURIO_OS_DRIVERS_VGA_H__
