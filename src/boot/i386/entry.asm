global _start
extern kernel_main

; Multiboot header
section .multiboot
    MULTIBOOT_MAGIC    equ 0x1BADB002
    MULTIBOOT_FLAGS    equ 0
    MULTIBOOT_CHECKSUM equ -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS)

    align 4
    dd MULTIBOOT_MAGIC
    dd MULTIBOOT_FLAGS
    dd MULTIBOOT_CHECKSUM

section .text
_start:
    ; Set up stack
    mov esp, stack_top

    ; Call kernel main function
    call kernel_main

    ; Halt if kernel returns
.halt:
    cli
    hlt
    jmp .halt

section .bss
    ; 16 KB stack
    stack_bottom:
    resb 16384
    stack_top:
