; Bootloader for x86_64 with Multiboot2 support
global _start
extern kernel_main

section .multiboot2_header
align 8
header_start:
    dd 0xe85250d6                ; Multiboot2 magic number
    dd 0                         ; Architecture (i386)
    dd header_end - header_start ; Header length
    ; Checksum
    dd 0x100000000 - (0xe85250d6 + 0 + (header_end - header_start))

    ; Required end tag
    dw 0    ; Type
    dw 0    ; Flags
    dd 8    ; Size
header_end:

; Page table entries
section .bss
align 4096
p4_table:
    resb 4096
p3_table:
    resb 4096
p2_table:
    resb 4096
stack_bottom:
    resb 16384  ; 16 KB stack
stack_top:

section .text
bits 32
_start:
    ; Setup stack
    mov esp, stack_top

    ; Store multiboot info
    push ebx    ; Multiboot info pointer
    push eax    ; Multiboot magic value

    ; Clear page tables
    mov edi, p4_table
    xor eax, eax
    mov ecx, 4096*3
    rep stosd

    ; Setup page tables for identity mapping first 2MB
    ; P4 Entry
    mov eax, p3_table
    or eax, 0b11    ; Present + Writable
    mov [p4_table], eax

    ; P3 Entry
    mov eax, p2_table
    or eax, 0b11    ; Present + Writable
    mov [p3_table], eax

    ; P2 Entry - Identity map first 2MB
    mov ecx, 0
.map_p2:
    mov eax, 0x200000  ; 2MB page
    mul ecx
    or eax, 0b10000011 ; Present + Writable + Huge
    mov [p2_table + ecx * 8], eax

    inc ecx
    cmp ecx, 512      ; Map entire P2 (1GB)
    jne .map_p2

    ; Load P4 into CR3
    mov eax, p4_table
    mov cr3, eax

    ; Enable PAE
    mov eax, cr4
    or eax, 1 << 5    ; PAE bit
    mov cr4, eax

    ; Enable Long Mode
    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8    ; Long Mode Enable
    wrmsr

    ; Enable paging
    mov eax, cr0
    or eax, 1 << 31   ; Paging bit
    or eax, 1         ; Protected mode bit
    mov cr0, eax

    ; Load GDT
    lgdt [gdt64.pointer]

    ; Update selectors
    mov ax, gdt64.data
    mov ss, ax
    mov ds, ax
    mov es, ax

    ; Jump to long mode
    jmp gdt64.code:long_mode_start

bits 64
long_mode_start:
    ; Clear old segments
    xor ax, ax
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Restore multiboot info for kernel
    pop rdi    ; Magic value
    pop rsi    ; Info pointer

    ; Set up fresh stack for 64-bit mode
    mov rsp, stack_top

    ; Call kernel
    call kernel_main

    ; Kernel should not return, but if it does:
.hang:
    cli
    hlt
    jmp .hang

section .rodata
gdt64:
    dq 0 ; Zero entry
.code: equ $ - gdt64
    ; Code segment
    dq (1 << 43) | (1 << 44) | (1 << 47) | (1 << 53) ; Code segment
.data: equ $ - gdt64
    ; Data segment
    dq (1 << 44) | (1 << 47) | (1 << 41) ; Data segment
.pointer:
    dw $ - gdt64 - 1     ; Length
    dq gdt64             ; Base
