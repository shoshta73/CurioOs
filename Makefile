include config.mk

.PHONY: all clean
all: clean kernel iso

.DEFAULT_GOAL := build
build: kernel iso

run: iso
	qemu-system-x86_64 -drive file=os-image,format=raw

iso: kernel grub.cfg
	mkdir -p iso/boot/grub
	cp -fv kernel iso/boot/kernel
	cp -fv grub.cfg iso/boot/grub/grub.cfg
	grub-mkrescue -o os-image iso

kernel: linker.ld src/start.o src/main.o src/vga.o src/gdt.o src/idt.o src/isrs.o src/irq.o src/timer.o
	$(LD) $(LD_FLAGS) src/*.o

src/start.o: src/start.asm
	$(compile_asm)

src/main.o: src/main.c
	$(compile_c)

src/vga.o: src/vga.c
	$(compile_c)

src/gdt.o: src/gdt.c
	$(compile_c)

src/idt.o: src/idt.c
	$(compile_c)

src/isrs.o: src/isrs.c
	$(compile_c)

src/irq.o: src/irq.c
	$(compile_c)

src/timer.o: src/timer.c
	$(compile_c)

clean:
	rm -fv kernel
	rm -fv src/*.o
	rm -rfv iso
	rm -fv os-image
