CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -O2
SRC_DIR = src
BUILD_DIR = build
PROG_DIR = programs

# Targets
EMULATOR = $(BUILD_DIR)/emulator
ASSEMBLER = $(BUILD_DIR)/assembler

# Source files
EMU_SRCS = $(SRC_DIR)/cpu.c $(SRC_DIR)/emulator_main.c
ASM_SRCS = $(SRC_DIR)/assembler.c $(SRC_DIR)/assembler_main.c

# Object files
EMU_OBJS = $(BUILD_DIR)/cpu.o $(BUILD_DIR)/emulator_main.o
ASM_OBJS = $(BUILD_DIR)/assembler.o $(BUILD_DIR)/assembler_main.o

# Default target
all: $(BUILD_DIR) $(EMULATOR) $(ASSEMBLER)

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build emulator
$(EMULATOR): $(EMU_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Build assembler
$(ASSEMBLER): $(ASM_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compile CPU module
$(BUILD_DIR)/cpu.o: $(SRC_DIR)/cpu.c $(SRC_DIR)/cpu.h
	$(CC) $(CFLAGS) -c -o $@ $<

# Compile emulator main
$(BUILD_DIR)/emulator_main.o: $(SRC_DIR)/emulator_main.c $(SRC_DIR)/cpu.h
	$(CC) $(CFLAGS) -c -o $@ $<

# Compile assembler module
$(BUILD_DIR)/assembler.o: $(SRC_DIR)/assembler.c $(SRC_DIR)/assembler.h $(SRC_DIR)/cpu.h
	$(CC) $(CFLAGS) -c -o $@ $<

# Compile assembler main
$(BUILD_DIR)/assembler_main.o: $(SRC_DIR)/assembler_main.c $(SRC_DIR)/assembler.h
	$(CC) $(CFLAGS) -c -o $@ $<

# Assemble and run example programs
.PHONY: test_hello test_fibonacci test_timer test_all

test_hello: all
	@echo "=== Assembling and running Hello World ==="
	$(ASSEMBLER) $(PROG_DIR)/hello.asm -o $(BUILD_DIR)/hello.bin
	$(EMULATOR) $(BUILD_DIR)/hello.bin

test_fibonacci: all
	@echo "=== Assembling and running Fibonacci ==="
	$(ASSEMBLER) $(PROG_DIR)/fibonacci.asm -o $(BUILD_DIR)/fibonacci.bin
	$(EMULATOR) $(BUILD_DIR)/fibonacci.bin

test_timer: all
	@echo "=== Assembling and running Timer (with trace) ==="
	$(ASSEMBLER) $(PROG_DIR)/timer.asm -o $(BUILD_DIR)/timer.bin
	$(EMULATOR) $(BUILD_DIR)/timer.bin --trace

test_all: test_hello test_fibonacci test_timer

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

# Help
help:
	@echo "SimpleCPU16 Build System"
	@echo "========================"
	@echo ""
	@echo "Targets:"
	@echo "  all           - Build emulator and assembler"
	@echo "  test_hello    - Run Hello World program"
	@echo "  test_fibonacci - Run Fibonacci program"
	@echo "  test_timer    - Run Timer demo with trace"
	@echo "  test_all      - Run all test programs"
	@echo "  clean         - Remove build artifacts"
	@echo "  help          - Show this help message"
