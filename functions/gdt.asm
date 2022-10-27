; GDT
gdt_start:

gdt_null: ; mandatory null descriptor
    dd 0x0 ; dd = double word (4 bytes)
    dd 0x0 ; we define 8 bytes in total

gdt_code: ; code segment descriptor
    ; base=0x0, limit=0xfffff; this just means that we want to use the whole memory
    ; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (size)1 (reserved)0 (available)0 -> 1100b

    dw 0xffff ; limit, bits 0-15
    dw 0x0 ; base, bits 0-15
    db 0x0 ; base, bits 16-23
    db 10011010b ; flags
    db 11001111b ; more flags

    db 0x0 ; base, bits 24-31

gdt_data: ; data segment descriptor
    ; same as code segment descriptor, but with different type flags
    ; type flags: (code)0 (expand-down)0 (writable)1 (accessed)0 -> 0010b
    dw 0xffff ; limit, bits 0-15
    dw 0x0 ; base, bits 0-15
    db 0x0 ; base, bits 16-23
    db 10010010b ; flags
    db 11001111b ; more flags
    db 0x0 ; base, bits 24-31

gdt_end:
; The GDT is now defined. We need to tell the CPU where it is located.

; gdt descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of GDT
    dd gdt_start ; address of GDT

; define some handy constants for the GDT segment descriptor offsets, which
; are what segment registers must contain when in protected mode. For example,
; when we set DS = 0x10 in PM, the CPU knows that we mean it to use the
; segment described at offset 0x10 (i.e. 16 bytes) in our GDT, which in our
; case is the DATA segment (0x0 -> NULL; 0x08 -> CODE; 0x10 -> DATA)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start