#include <core/io.h>

#include <stdint.h>

void outl(uint16_t port, uint32_t value)
{
    asm volatile("outl %0, %1" : : "a"(value), "Nd"(port) : "memory");
}
