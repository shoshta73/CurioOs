#include <core/io.h>

#include <stdint.h>

uint32_t inl(uint16_t port)
{
    uint32_t value;
    asm volatile("inl %1, %0" : "=a"(value) : "Nd"(port) : "memory");
    return value;
}
