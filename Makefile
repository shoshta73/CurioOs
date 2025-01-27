include config.mk

_IO_SOURCES = $(wildcard src/core/*.c)
_VGA_DRIVER_SOURCE = $(wildcard src/drivers/vga/*.c)
_KERNEL_SOURCES = $(wildcard src/kernel/*.c)
KERNEL_SRCS = $(_KERNEL_SOURCES) $(_VGA_DRIVER_SOURCE) $(_IO_SOURCES)

KERNEL_OBJS = $(KERNEL_SRCS:.c=.o)
ASM_OBJS = $(ASM_SRCS:.asm=.o)

# Target
TARGET = CurioOS.iso

# Default target
all: $(TARGET)

run: $(TARGET)
	qemu-system-$(ARCH) -cdrom $<

# Compile C sources
%.o: %.c
	$(CC) $(CC_FLAGS) -c $< -o $@

# Compile assembly sources
%.o: %.asm
	$(NASM) $(NASMFLAGS) $< -o $@

# Link kernel
kernel.bin: $(KERNEL_OBJS) $(ASM_OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

# Create ISO
$(TARGET): kernel.bin
	mkdir -p iso/boot/grub
	cp -v kernel.bin iso/boot/
	cp -fv build/$(ARCH)/grub.cfg iso/boot/grub/
	grub-mkrescue -o $@ iso

# Clean
clean:
	rm -rfv $(KERNEL_OBJS) $(ASM_OBJS) kernel.bin iso $(TARGET)

.PHONY: all clean
