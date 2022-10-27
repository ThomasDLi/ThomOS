[org 0x7c00]                                ; bootloader starts at memory location 0x7c00

mov bx, loadedrm                            ; bx is the argument to the print function
call print_string                           ; print the message

mov bx, loadpm
call print_string

call switch_to_pm                          ; switch to protected mode, we never return from this call. THE VOID.

jmp $                                       ; hang

%include "functions/print_string.asm"       ; "function" to print a string
%include "functions/gdt.asm"                ; gdt table
%include "functions/enter_pm.asm"           ; function to switch to protected mode

[bits 32]

BEGIN_PM:

    [bits 32]

    

    jmp $                                   ; hang

loadedrm:
    db "Loaded into 16-bit real mode.",13, 10, 0            ; 13 is carriage return, 10 is line feed

loadpm:
    db "Loading into 32-bit protected mode.",13, 10, 0

loadedpm:
    db "Loaded into 32-bit protected mode.",13, 10, 0

times 510-($-$$) db 0                       ; fill rest to 0 for 512 bytes
db 0x55, 0xaa                               ; set last 2 bytes to 0xaa55