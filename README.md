# unamefetch

`uname -a` in a nicer format, written in x86 assembly.

```
$ nasm -f elf unamefetch.asm
$ ld -m elf_i386 unamefetch.o -o unamefetch
$ ./unamefetch
> sysname: Linux
> release: 6.7.10
> machine: x86_64
> nodename: NixBtw
> version: #1-NixOS SMP PREEMPT_DYNAMIC Fri Mar 15 18:22:41 UTC 2024
```
