; 64-bit Multiboot2 Bootloader

global _start
extern kernel_main

; Multiboot2 header constants
MULTIBOOT2_MAGIC        equ 0xE85250D6
MULTIBOOT2_ARCH_I386    equ 0
MULTIBOOT2_LENGTH       equ multiboot2_header_end - multiboot2_header_start
MULTIBOOT2_CHECKSUM     equ -(MULTIBOOT2_MAGIC + MULTIBOOT2_ARCH_I386 + MULTIBOOT2_LENGTH)

; Page table and memory management constants
PAGE_PRESENT    equ 1 << 0
PAGE_WRITE      equ 1 << 1
PAGE_USER       equ 1 << 2
PAGE_SIZE       equ 1 << 7

section .multiboot2_header
multiboot2_header_start:
    dd MULTIBOOT2_MAGIC
    dd MULTIBOOT2_ARCH_I386
    dd MULTIBOOT2_LENGTH
    dd MULTIBOOT2_CHECKSUM

    ; Multiboot2 tags (optional)
    ; Framebuffer tag
    dw 5      ; type
    dw 0      ; flags
    dd 20     ; size
    dd 1024   ; width
    dd 768    ; height
    dd 32     ; depth

    ; End tag
    dw 0      ; type
    dw 0      ; flags
    dd 8      ; size
multiboot2_header_end:

section .bss
    ; Page tables
    align 4096
pml4:
    resb 4096
pdp:
    resb 4096
pd:
    resb 4096
pt:
    resb 4096

    ; Stack
    stack_bottom:
    resb 16384
stack_top:

section .data
    ; Global Descriptor Table
gdt64:
    .null: equ $ - gdt64
        dq 0
    .code: equ $ - gdt64
        dq 0x00209A0000000000 ; Long mode code segment
    .data: equ $ - gdt64
        dq 0x0000920000000000 ; Data segment
    .end: equ $ - gdt64

    ; GDT descriptor
gdt64_descriptor:
    dw gdt64.end - gdt64 - 1
    dq gdt64

section .text
global _start
_start:
    ; Disable interrupts
    cli

    ; Check multiboot2 magic
    cmp eax, 0x36d76289
    jne .error

    ; Setup page tables
    call setup_page_tables
    call enable_paging

    ; Load 64-bit GDT
    lgdt [gdt64_descriptor]

    ; Far jump to 64-bit code
    jmp gdt64.code:long_mode_start

; Page table setup
setup_page_tables:
    ; Clear page tables
    mov edi, pml4
    mov cr3, edi
    xor eax, eax
    mov ecx, 4096
    rep stosd

    ; Identity map first 2MB
    mov edi, pml4
    mov DWORD [edi], pdp + PAGE_PRESENT + PAGE_WRITE
    mov edi, pdp
    mov DWORD [edi], pd + PAGE_PRESENT + PAGE_WRITE
    mov edi, pd
    mov DWORD [edi], pt + PAGE_PRESENT + PAGE_WRITE

    ; Fill page table
    mov ecx, 512
    mov edi, pt
    mov esi, 0
.map_pt_loop:
    mov QWORD [edi], esi | PAGE_PRESENT | PAGE_WRITE
    add esi, 0x1000
    add edi, 8
    loop .map_pt_loop

    ret

; Enable paging and long mode
enable_paging:
    ; Enable PAE
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    ; Enable long mode
    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    ; Enable paging
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

    ret

; 64-bit Long Mode Entry Point
[BITS 64]
long_mode_start:
    ; Load segment registers
    mov ax, gdt64.data
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Setup stack
    mov rsp, stack_top

    ; Call kernel main
    call kernel_main

.halt:
    cli
    hlt
    jmp .halt

.error:
    ; Handle multiboot2 error
    mov al, '0'
    jmp .halt
