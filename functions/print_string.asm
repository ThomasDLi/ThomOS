print_string:             ; prints string from address in BX
    
    mov ah, 0x0e          ; selects teletype BIOS function
    mov al, [bx]          ; gets the character to print
    int 0x10              ; calls the BIOS interrupt
    inc bx                ; increments the string pointer to the next character
    mov al, [bx]          ; gets the character to print
    cmp al, 0             ; checks if the character is the null terminator
    jne print_string      ; if not, print the next character

    ret                   ; return to the caller