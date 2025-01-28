include config.mk

.PHONY: all clean
all: kernel iso

iso: kernel
	mkdir -p iso/boot/grub
	cp -fv kernel iso/boot/kernel
	cp -fv grub.cfg iso/boot/grub/grub.cfg
	grub-mkrescue -o os-image iso

kernel: linker.ld src/start.o src/main.o src/vga.o
	$(LD) $(LD_FLAGS) src/start.o src/main.o src/vga.o

src/start.o: src/start.asm
	$(AS) $(AS_FLAGS) $@ $<

src/main.o: src/main.c
	$(CC) $(CC_FLAGS) $@ $<

src/vga.o: src/vga.c
	$(CC) $(CC_FLAGS) $@ $<

clean:
	rm -fv kernel
	rm -fv src/*.o
	rm -rfv iso
