#include <core/io.h>

#include <stdint.h>

uint16_t inw(uint16_t port)
{
    uint16_t value;
    asm volatile("inw %1, %0" : "=a"(value) : "Nd"(port) : "memory");
    return value;
}
