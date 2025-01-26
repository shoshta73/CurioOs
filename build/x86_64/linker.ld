ENTRY(_start)

SECTIONS
{
    . = 2M;

    .text ALIGN(4K) :
    {
        *(.multiboot2_header)
        *(.text)
    }

    .rodata ALIGN(4K) :
    {
        *(.rodata)
    }

    .data ALIGN(4K) :
    {
        *(.data)
    }

    .bss ALIGN(4K) :
    {
        *(COMMON)
        *(.bss)
    }

    end = .;
}
