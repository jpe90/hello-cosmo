# Hello-cosmo

A makefile project to demonstrate building a portable Hello World executable with [Cosmopolitan Libc](https://github.com/jart/cosmopolitan)

# Building

## Linux

```bash
$ make
```

## MacOS

```bash
$ brew install x86_64-elf-gcc
$ make CC=x86_64-elf-gcc OBJCOPY=x86_64-elf-objcopy
```

## Windows

See https://justine.lol/cosmopolitan/windows-compiling.html

# Running

```bash
$ ./hello.com
```

## Note: Running with ZSH

ZSH does not currently work, you'll see the following error:
```bash
zsh: exec format error: ./hello.com
```

You need to run with Bash until a pending fix is merged upstream:

```bash
$ bash -c './hello.com'
```
