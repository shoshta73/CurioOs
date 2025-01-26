ARCH := i386
# ARCH := x86_64

CC = gcc
NASM = nasm
LD = ld

CFLAGS :=
NASMFLAGS :=
LDFLAGS :=

ifeq ($(ARCH), i386)
	CFLAGS += -m32 -ffreestanding -O2 -Wall -Wextra
	NASMFLAGS += -f elf32
	LDFLAGS += -m elf_i386 -T build/$(ARCH)/linker.ld
endif

ifeq ($(ARCH), x86_64)
	CFLAGS += -ffreestanding -O2 -Wall -Wextra
	NASMFLAGS += -f elf64
	LDFLAGS += -m elf_x86_64 -T build/$(ARCH)/linker.ld
endif

ASM_SRCS := src/boot/$(ARCH)/entry.asm
