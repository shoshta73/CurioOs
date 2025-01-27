#ifndef __CURIO_OS_KERNEL_IO_H__
#define __CURIO_OS_KERNEL_IO_H__ 1

#include <stdint.h>

void _kprint_char_color(char c, uint8_t color);
void _kprint_char(char c);
void _kprint_string_color(const char *str, uint8_t color);
void _kprint_string(const char *str);

void kprint(const char *str);
void kputc(char c);

#endif // __CURIO_OS_KERNEL_IO_H__
