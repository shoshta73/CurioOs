# Makefile for Minimal OS

# Compiler and linker settings
CC = gcc
NASM = nasm
LD = ld

# Architecture (uncomment one)
ARCH = i386
# Compilation flags
CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra
NASMFLAGS = -f elf32
LDFLAGS = -m elf_i386

# ARCH = x86_64
# Compilation flags
# CFLAGS = -ffreestanding -O2 -Wall -Wextra
# NASMFLAGS = -f elf64
# LDFLAGS = -m elf_x86_64

# Source files
KERNEL_SRCS = kmain.c
ASM_SRCS = boot.asm

# Object files
KERNEL_OBJS = $(KERNEL_SRCS:.c=.o)
ASM_OBJS = $(ASM_SRCS:.asm=.o)

# Target
TARGET = minimal_os.iso

# Default target
all: $(TARGET)

run: $(TARGET)
	qemu-system-i386 -cdrom $<

# Compile C sources
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Compile assembly sources
%.o: %.asm
	$(NASM) $(NASMFLAGS) $< -o $@

# Link kernel
kernel.bin: $(KERNEL_OBJS) $(ASM_OBJS)
	$(LD) $(LDFLAGS) -T linker.ld -o $@ $^

# Create ISO
$(TARGET): kernel.bin
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/
	cp grub.cfg iso/boot/grub/
	grub-mkrescue -o $@ iso

# Clean
clean:
	rm -rf *.o **/*.o kernel.bin iso $(TARGET)

.PHONY: all clean
