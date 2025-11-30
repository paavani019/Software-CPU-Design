# SimpleCPU16

A 16-bit CPU emulator and assembler written in C for educational purposes.

## What is This?

SimpleCPU16 is a complete software implementation of a 16-bit CPU that can:
- Assemble assembly language programs into binary code
- Execute binary programs with a virtual CPU
- Show step-by-step execution traces for learning

## Quick Start

### 1. Build the Project

```bash
make all
```

This creates:
- `build/assembler` - Converts assembly code to binary
- `build/emulator` - Runs binary programs

### 2. Run Example Programs

```bash
# Run Hello World
make test_hello

# Run Fibonacci sequence (prints 0 1 1 2 3 5 8 13 21 34)
make test_fibonacci

# Run timer demo with detailed trace
make test_timer

# Run all tests
make test_all
```

## How to Write and Run Your Own Program

### Step 1: Write Assembly Code

Create a file `myprogram.asm`:

```assembly
.ORG 0x0000

start:
    LDI R0, 42          ; Load 42 into register R0
    ST [0xF801], R0     ; Print the number
    HALT                ; Stop execution
```

### Step 2: Assemble It

```bash
./build/assembler myprogram.asm -o myprogram.bin
```

### Step 3: Run It

```bash
./build/emulator myprogram.bin
```

Output:
```
42
```

## Example Programs Included

### 1. Hello World (`programs/hello.asm`)

Prints "Hello, World!" to the screen.

```bash
make test_hello
```

### 2. Fibonacci (`programs/fibonacci.asm`)

Calculates and prints the first 10 Fibonacci numbers.

```bash
make test_fibonacci
```

### 3. Timer (`programs/timer.asm`)

Demonstrates CPU execution cycles with detailed trace output.

```bash
make test_timer
```

## Available Commands

| Command | Description |
|---------|-------------|
| `make all` | Build emulator and assembler |
| `make clean` | Remove all build files |
| `make test_hello` | Run Hello World program |
| `make test_fibonacci` | Run Fibonacci program |
| `make test_timer` | Run Timer demo with trace |
| `make test_all` | Run all test programs |

## Emulator Options

```bash
./build/emulator <program.bin> [options]
```

**Options:**
- `--trace` - Show detailed execution trace (every instruction)
- `--memdump <file>` - Save memory contents to a file
- `--help` - Show help message

**Examples:**

```bash
# Normal execution
./build/emulator build/hello.bin
.\build\emulator.exe build\hello.bin
.\build\emulator.exe build\fibonacci.bin
.\build\emulator.exe build\timer.bin --trace
./run_all.ps1

# With execution trace (see every instruction)
./build/emulator build/fibonacci.bin --trace

# With memory dump after execution
./build/emulator build/timer.bin --memdump memory.txt
```

## Assembly Language Basics

### Registers

- `R0` to `R7` - General purpose registers
- `R7` (or `SP`) - Stack pointer

### Common Instructions

```assembly
LDI R0, 100        ; Load immediate: R0 = 100
LD R1, [0x1000]    ; Load from memory: R1 = Memory[0x1000]
ST [0x1000], R2    ; Store to memory: Memory[0x1000] = R2
ADD R0, R1         ; Add: R0 = R0 + R1
SUB R0, R1         ; Subtract: R0 = R0 - R1
MUL R0, R1         ; Multiply: R0 = R0 * R1
CMP R0, R1         ; Compare (sets flags)
BEQ label          ; Branch if equal
JMP label          ; Jump to label
HALT               ; Stop execution
```

### Input/Output

```assembly
; Print a character
LDI R0, 65              ; ASCII 'A'
ST [0xF800], R0         ; Print character

; Print a number
LDI R1, 42
ST [0xF801], R1         ; Print "42"

; Print a string
LDI R2, message
ST [0xF802], R2         ; Print string

message:
    .STRING "Hello!"
```

### Directives

```assembly
.ORG 0x0000            ; Set starting address
.WORD 0x1234           ; Insert raw 16-bit value
.STRING "text"         ; Insert null-terminated string
```

### Comments

```assembly
; This is a comment
LDI R0, 100    ; This is also a comment
```

## Project Structure

```
SimpleCPU16/
├── README.md              # This file
├── Makefile               # Build system
├── src/                   # Source code
│   ├── cpu.c              # CPU emulator
│   ├── cpu.h
│   ├── assembler.c        # Assembler
│   ├── assembler.h
│   ├── emulator_main.c
│   └── assembler_main.c
├── programs/              # Example programs
│   ├── hello.asm
│   ├── fibonacci.asm
│   └── timer.asm
├── docs/                  # Documentation
│   ├── ISA.md             # Complete instruction reference
│   ├── ARCHITECTURE.md    # CPU architecture details
│   └── cpu_schematic.txt  # CPU diagram
└── build/                 # Build output (created by make)
```

## Features

- **8 Registers**: R0-R7 (R7 is stack pointer)
- **64K Memory**: 65,536 words of 16-bit memory
- **35+ Instructions**: Arithmetic, logic, branches, I/O, and more
- **4 Condition Flags**: Zero (Z), Negative (N), Carry (C), Overflow (V)
- **Memory-Mapped I/O**: For character, integer, and string output
- **Two-Pass Assembler**: Supports labels and forward references
- **Trace Mode**: See exactly what the CPU is doing

## Memory Map

```
0x0000 - 0xDFFF : Program Memory
0xE000 - 0xF7FF : Stack (grows downward)
0xF800 - 0xFFFF : Memory-Mapped I/O
```

### I/O Addresses

| Address | Device | Purpose |
|---------|--------|---------|
| 0xF800 | CHAR_OUT | Write character |
| 0xF801 | INT_OUT | Write integer |
| 0xF802 | STR_OUT | Write string |
| 0xF810 | TIMER | Read cycle counter |
| 0xF820 | CHAR_IN | Read character |

## Documentation

For detailed information:

- **ISA Reference**: See `docs/ISA.md` for complete instruction set
- **Architecture**: See `docs/ARCHITECTURE.md` for CPU design details
- **Diagrams**: See `docs/cpu_schematic.txt` for visual CPU layout

## Sample Program Walkthrough

Here's a simple program that adds two numbers:

```assembly
.ORG 0x0000

start:
    LDI R0, 10          ; Load 10 into R0
    LDI R1, 32          ; Load 32 into R1
    ADD R0, R1          ; R0 = R0 + R1 = 42
    ST [0xF801], R0     ; Print result (42)
    HALT                ; Stop
```

**To run it:**

1. Save as `add.asm`
2. Assemble: `./build/assembler add.asm -o add.bin`
3. Run: `./build/emulator add.bin`
4. Output: `42`

## Troubleshooting

### "make: command not found"

Install build tools:
- **macOS**: `xcode-select --install`
- **Linux**: `sudo apt install build-essential`

### "Cannot open binary file"

Make sure you assembled the program first:
```bash
./build/assembler programs/hello.asm -o build/hello.bin
./build/emulator build/hello.bin
```

### "Permission denied"

Make executables runnable:
```bash
chmod +x build/emulator build/assembler
```

## Clean Build

To rebuild everything from scratch:

```bash
make clean
make all
```

## Technical Details

| Specification | Value |
|--------------|-------|
| Word Size | 16 bits |
| Memory Size | 64K words (128 KB) |
| Registers | 8 general-purpose |
| Instruction Length | 1-2 words |
| Opcodes | 16 primary opcodes |
| Addressing Modes | Immediate, Direct, Indirect, Register |

## What You Can Learn

This project demonstrates:

1. **Computer Architecture**: How CPUs fetch, decode, and execute instructions
2. **Assembly Language**: Low-level programming concepts
3. **Compilers**: How assemblers translate code to machine language
4. **Memory Management**: Stack, heap, and memory-mapped I/O
5. **System Programming**: Building system-level tools in C

## Example Output

```bash
$ make test_fibonacci
SimpleCPU16 Emulator v1.0
==========================

Program loaded: 19 words at address 0x0000

=== Starting CPU Execution ===
0
1
1
2
3
5
8
13
21
34

=== CPU Halted ===
Total cycles: 85
```

## License

Educational project - free to use and modify.

## Author

Created for CMPE 220 - Computer Architecture coursework.

---

**Need Help?** Check the documentation in the `docs/` folder for complete details on the instruction set and architecture.

### Windows (PowerShell) Quick Run

If you're on Windows and don't have `make` installed, you can build and run everything from PowerShell using `gcc` (MSYS2 / MinGW). From the project root run:

```powershell
if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }
gcc -Wall -Wextra -std=c99 -O2 -c -o build/cpu.o src/cpu.c
gcc -Wall -Wextra -std=c99 -O2 -c -o build/emulator_main.o src/emulator_main.c
gcc -Wall -Wextra -std=c99 -O2 -o build/emulator build/cpu.o build/emulator_main.o
gcc -Wall -Wextra -std=c99 -O2 -c -o build/assembler.o src/assembler.c
gcc -Wall -Wextra -std=c99 -O2 -c -o build/assembler_main.o src/assembler_main.c
gcc -Wall -Wextra -std=c99 -O2 -o build/assembler build/assembler.o build/assembler_main.o

# Assemble and run Hello World
.\build\assembler.exe programs\hello.asm -o build\hello.bin
.\build\emulator.exe build\hello.bin

# Assemble and run Fibonacci
.\build\assembler.exe programs\fibonacci.asm -o build\fibonacci.bin
.\build\emulator.exe build\fibonacci.bin

# Assemble and run Timer (with trace)
.\build\assembler.exe programs\timer.asm -o build\timer.bin
.\build\emulator.exe build\timer.bin --trace
```

Notes:
- `make` may not be installed on some Windows systems; the commands above compile and run the project using `gcc` from MSYS2 or MinGW-w64.
- The compiled binaries will be placed in the `build/` directory: `build\assembler.exe`, `build\emulator.exe`, and the assembled program binaries like `build\hello.bin`.

For convenience, see the provided `run_all.ps1` script in the repository root which automates these steps.
