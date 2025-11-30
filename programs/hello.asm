; Hello World Program
; Demonstrates string output using memory-mapped I/O

.ORG 0x0000

start:
    LDI R0, msg           ; Load address of message string
    ST [0xF802], R0       ; Write to MMIO_STR_OUT to print string
    HALT                  ; Stop execution

msg:
    .STRING "Hello, World!"
