LD := ld
LD_FLAGS := -m elf_i386 -T linker.ld -o kernel

CC := gcc
CPP_FLAGS := -I./src/include
CC_FLAGS := $(CPP_FLAGS) -m32 -ffreestanding -nostdlib -Wall -m32 -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -fno-stack-protector -fno-pie -c -o

AS := nasm
AS_FLAGS := -f elf32 -o
