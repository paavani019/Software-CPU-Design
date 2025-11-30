; Timer Demonstration Program
; Shows Fetch/Compute/Store execution cycles
; Reads timer value and performs computations

.ORG 0x0000

start:
    ; === FETCH & LOAD IMMEDIATE ===
    ; Instruction fetched from memory at PC
    LDI R0, 100           ; Load immediate value 100 into R0

    ; === FETCH & READ TIMER (MMIO) ===
    ; Read cycle counter from memory-mapped I/O
    LDI R5, 0xF810        ; Load MMIO_TIMER address into R5
    LD R1, [R5]           ; Read timer value via indirect addressing

    ; === COMPUTE CYCLE ===
    ; ALU performs addition
    ADD R0, R1            ; R0 = R0 + R1 (100 + timer)

    ; === STORE CYCLE ===
    ; Result written to memory
    ST [0x1000], R0       ; Store result at memory location 0x1000

    ; === LOAD & PRINT ===
    LD R2, [0x1000]       ; Load back from memory
    ST [0xF801], R2       ; Print result to MMIO_INT_OUT

    ; === ANOTHER EXAMPLE: MULTIPLICATION ===
    LDI R3, 5             ; Load 5
    LDI R4, 7             ; Load 7
    MUL R3, R4            ; R3 = R3 * R4 = 35
    ST [0xF801], R3       ; Print result

    HALT
