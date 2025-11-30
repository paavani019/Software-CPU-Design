; Fibonacci Sequence Generator
; Generates first 10 Fibonacci numbers and prints them

.ORG 0x0000

start:
    LDI R0, 0             ; First Fibonacci number (F0 = 0)
    LDI R1, 1             ; Second Fibonacci number (F1 = 1)
    LDI R2, 10            ; Counter (generate 10 numbers)
    LDI R3, 0             ; Loop counter

print_loop:
    ; Print current Fibonacci number (in R0)
    ST [0xF801], R0       ; Print integer via MMIO
    
    ; Calculate next Fibonacci: R4 = R0 + R1
    MOV R4, R0
    ADD R4, R1
    
    ; Shift values: R0 = R1, R1 = R4
    MOV R0, R1
    MOV R1, R4
    
    ; Increment loop counter
    INC R3
    
    ; Check if we've printed 10 numbers
    CMP R3, R2
    BLT print_loop        ; Continue if R3 < R2
    
    HALT

