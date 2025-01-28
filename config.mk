LD := ld
LD_FLAGS := -m elf_i386 -T linker.ld -o kernel

CC := gcc
CPP_FLAGS := -I./src/include
CC_FLAGS := $(CPP_FLAGS) -m32 -ffreestanding -nostdlib -Wall -m32 -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -fno-stack-protector -fno-pie -c -o

AS := nasm
AS_FLAGS := -f elf32 -o

_RED := \033[31m
_GREEN := \033[32m
_YELLOW := \033[33m
_NC := \033[0m

define compile_c
	@printf "[ $(CC) ] [ ???? ] Compiling $<\r"
	@if $(CC) $(CC_FLAGS) $@ $< > compile.log 2>&1; then \
		printf "[ $(CC) ] $(_GREEN)[ DONE ]$(_NC) Compiled $< \r\n"; \
		if [ -s compile.log ]; then \
			printf "[ $(CC) ] $(_YELLOW)[ WARN ]$(_NC) Warnings in $<\r\n"; \
			cat compile.log; \
		fi; \
		rm -f compile.log; \
	else \
		printf "[ $(CC) ] $(_RED)[ FAIL ]$(_NC) Failed to compile $<\r\n"; \
		cat compile.log; \
		rm -f compile.log; \
		exit 1; \
	fi
endef

define compile_asm
	@printf "[ $(AS) ] [ ???? ] Compiling $<\r"
	@if $(AS) $(AS_FLAGS) $@ $< > compile.log 2>&1; then \
		printf "[ $(AS) ] $(_GREEN)[ DONE ]$(_NC) Compiled $< \r\n"; \
		if [ -s compile.log ]; then \
			printf "[ $(AS) ] $(_YELLOW)[ WARN ]$(_NC) Warnings in $<\r\n"; \
			cat compile.log; \
		fi; \
		rm -f compile.log; \
	else \
		printf "[ $(AS) ] $(_RED)[ FAIL ]$(_NC) Failed to compile $<\r\n"; \
		cat compile.log; \
		rm -f compile.log; \
		exit 1; \
	fi
endef
