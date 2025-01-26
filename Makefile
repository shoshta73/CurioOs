include config.mk

KERNEL_SRCS = src/kernel/main.c src/drivers/vga/clear_screen.c src/drivers/vga/print_char.c src/drivers/vga/print_string.c src/drivers/vga/state.c

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
	cp kernel.bin iso/boot/
	cp grub.cfg iso/boot/grub/
	grub-mkrescue -o $@ iso

# Clean
clean:
	rm -rfv $(KERNEL_OBJS) $(ASM_OBJS) kernel.bin iso $(TARGET)

.PHONY: all clean
