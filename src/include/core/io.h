#ifndef __CURIOOS_IO_H__
#define __CURIOOS_IO_H__ 1

#include <stdint.h>

void outb(uint16_t port, uint8_t value);
uint8_t inb(uint16_t port);

void outw(uint16_t port, uint16_t value);
uint16_t inw(uint16_t port);

void outl(uint16_t port, uint32_t value);
uint32_t inl(uint16_t port);

void wait(void);

#endif // __CURIOOS_IO_H__
