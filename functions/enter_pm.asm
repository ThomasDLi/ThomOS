[bits 16]

switch_to_pm:

    cli             ; disable interrupts until we enter protected mode
                    ; or the interupt handler will bug out
    
    lgdt [gdt_descriptor]     ; load the GDT address pointer into the GDTR register

    mov eax , cr0
    or eax, 0x1
    mov cr0 , eax      ;set first bit of cr0 to 1 to enable protected mode

    jmp CODE_SEG:pm_start    ; jump to protected mode and force cache flush

[bits 32]      ;WHOOOO BABYYYY WE MADE IT TO PROTECTED MODE LETS FUCKING GOOOO IF THIS DOESNT COMPILE IM ACTUALLY GONNA KMS

pm_start:      ;LOOK MOM I DID IT

    mov ax, DATA_SEG                ; set general purpose reg to data segment
    mov ds, ax                      ; to the data segment selector
    mov es, ax                      ; and the extra segment selector
    mov fs, ax                      ; and the segment selector
    mov gs, ax                      ; and the segment selector
    mov ss, ax                      ; and the stack segment selector

    mov ebp, 0x90000                ; set the stack pointer to the top of the free space
    mov esp, ebp                    ; set the stack pointer to the top of the free space

    call BEGIN_PM                   ; jump to the beginning of the protected mode code