%macro value 2
	%1 db %2, 0x1b, "[m", 0x0f
	%1_len equ $ - %1
%endmacro

section .data
	prefix db 0x1b, "[1m", 0x1b, "[34m>", 0x1b, "[37m "
	prefix_len equ $ - prefix

	newline db 0xa
	newline_len equ 1

	value sysname, "sysname: "
	value release, "release: "
	value nodename, "nodename: "
	value machine, "machine: "
	value version, "version: "

	SYS_EXIT equ 60
	SYS_UNAME equ 63
	SYS_WRITE equ 1
	UTSNAME_SIZE equ 65

section .bss
	uname_result resb UTSNAME_SIZE*5

section .text
	global _start

%macro print 2
	mov rax, SYS_WRITE
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro print_l 1
	print %1, %1_len
%endmacro

%macro line 2
	print_l prefix
	print_l %1
	print uname_result + %2 * UTSNAME_SIZE, UTSNAME_SIZE
	print_l newline
%endmacro

_start:
	mov rax, SYS_UNAME
	mov rdi, uname_result
	syscall

	line sysname, 0
	line release, 2
	line machine, 4
	line nodename, 1
	line version, 3

	mov eax, SYS_EXIT
	xor rdi, rdi
	syscall
