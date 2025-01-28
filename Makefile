include config.mk

.PHONY: all clean
all: kernel iso

run: iso
	qemu-system-x86_64 -drive file=os-image,format=raw

iso: kernel grub.cfg
	mkdir -p iso/boot/grub
	cp -fv kernel iso/boot/kernel
	cp -fv grub.cfg iso/boot/grub/grub.cfg
	grub-mkrescue -o os-image iso

kernel: linker.ld src/start.o src/main.o src/vga.o src/gdt.o src/idt.o src/isrs.o
	$(LD) $(LD_FLAGS) src/*.o

src/start.o: src/start.asm
	$(AS) $(AS_FLAGS) $@ $<

src/main.o: src/main.c
	$(CC) $(CC_FLAGS) $@ $<

src/vga.o: src/vga.c
	$(CC) $(CC_FLAGS) $@ $<

src/gdt.o: src/gdt.c
	$(CC) $(CC_FLAGS) $@ $<

src/idt.o: src/idt.c
	$(CC) $(CC_FLAGS) $@ $<

src/isrs.o: src/isrs.c
	$(CC) $(CC_FLAGS) $@ $<

clean:
	rm -fv kernel
	rm -fv src/*.o
	rm -rfv iso
	rm -fv os-image
