# unamefetch

`uname -a`, but printed in a nicer format.

```
$ nasm -f elf64 unamefetch.asm
$ ld unamefetch.o -o unamefetch
$ ./unamefetch
> sysname: Linux
> release: 6.7.10
> machine: x86_64
> nodename: NixBtw
> version: #1-NixOS SMP PREEMPT_DYNAMIC Fri Mar 15 18:22:41 UTC 2024
```
