%macro value 2
	%1 db %2, 0x1b, "[m", 0x0f
	%1_len equ $ - %1
%endmacro

section .data
	prefix db 0x1b, "[1m", 0x1b, "[34m>", 0x1b, "[37m "
	prefix_len equ $ - prefix
	newline db 0xa

	value sysname, "sysname: "
	value release, "release: "
	value nodename, "nodename: "
	value machine, "machine: "
	value version, "version: "

	SYS_EXIT equ 1
	SYS_UNAME equ 122
	SYS_WRITE equ 4
	UTSNAME_SIZE equ 65

section .bss
	uname_result resb UTSNAME_SIZE*5

section .text
	global _start

%macro print 2
	mov eax, SYS_WRITE
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro

%macro print_l 1
	print %1, %1_len
%endmacro

%macro line 2
	print_l prefix
	print_l %1
	print uname_result + %2 * UTSNAME_SIZE, UTSNAME_SIZE
	print newline, 1
%endmacro

_start:
	mov eax, SYS_UNAME
	mov ebx, uname_result
	int 0x80

	line sysname, 0
	line release, 2
	line machine, 4
	line nodename, 1
	line version, 3

	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80
