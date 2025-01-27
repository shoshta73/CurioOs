#include <core/io.h>

#include <stdint.h>

void outb(uint16_t port, uint8_t value)
{
    asm volatile("outb %0, %1" : : "a"(value), "Nd"(port) : "memory");
}
