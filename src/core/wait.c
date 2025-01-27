#include <core/io.h>

void wait(void)
{
    outb(0x80, 0);
}
