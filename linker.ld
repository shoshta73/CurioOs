/* Linker script for Minimal OS */

ENTRY(_start)

SECTIONS
{
    /* Kernel starts at 1MB mark */
    . = 1M;

    /* Text section (code) */
    .text ALIGN(4K) :
    {
        *(.multiboot)
        *(.text)
    }

    /* Read-only data section */
    .rodata ALIGN(4K) :
    {
        *(.rodata)
    }

    /* Data section */
    .data ALIGN(4K) :
    {
        *(.data)
    }

    /* BSS section */
    .bss ALIGN(4K) :
    {
        *(COMMON)
        *(.bss)
    }

    /* End of kernel */
    end = .;
}
