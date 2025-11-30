# Run build + demos for SimpleCPU16 (PowerShell)
# Usage: Open PowerShell in the project root and run: .\run_all.ps1

# Create build dir if missing
if (!(Test-Path build)) { New-Item -ItemType Directory -Path build | Out-Null }

Write-Host "Compiling sources..."
gcc -Wall -Wextra -std=c99 -O2 -c -o build/cpu.o src/cpu.c
gcc -Wall -Wextra -std=c99 -O2 -c -o build/emulator_main.o src/emulator_main.c
gcc -Wall -Wextra -std=c99 -O2 -o build/emulator build/cpu.o build/emulator_main.o
gcc -Wall -Wextra -std=c99 -O2 -c -o build/assembler.o src/assembler.c
gcc -Wall -Wextra -std=c99 -O2 -c -o build/assembler_main.o src/assembler_main.c
gcc -Wall -Wextra -std=c99 -O2 -o build/assembler build/assembler.o build/assembler_main.o

if ($LASTEXITCODE -ne 0) {
    Write-Error "Compilation failed. Check output above."
    exit 1
}

Write-Host "\nAssembling and running Hello World..."
.\build\assembler.exe programs\hello.asm -o build\hello.bin
if ($LASTEXITCODE -ne 0) { Write-Error "Assembler failed"; exit 1 }
.\build\emulator.exe build\hello.bin

Write-Host "\nAssembling and running Fibonacci..."
.\build\assembler.exe programs\fibonacci.asm -o build\fibonacci.bin
if ($LASTEXITCODE -ne 0) { Write-Error "Assembler failed"; exit 1 }
.\build\emulator.exe build\fibonacci.bin

Write-Host "\nAssembling and running Timer (with trace)..."
.\build\assembler.exe programs\timer.asm -o build\timer.bin
if ($LASTEXITCODE -ne 0) { Write-Error "Assembler failed"; exit 1 }
.\build\emulator.exe build\timer.bin --trace

Write-Host "\nAll demos finished. Binaries in build\\"
