    org 100h
    section .text

    ;registros de apoyo
    mov SI, 201h
    mov BX, 001h
    mov byte[200h], "F"
    mov byte[201h], "J"
    mov byte[202h], "M"
    mov byte[203h], "H" 

    ;usando direccionamiento directo
    mov AX, [200h]

    ;usando direccionamiento indirecto por registro
    mov CX, [SI]

    ;usando direccionamiento indirecto base más índice.
    mov DX, [SI+BX]

    ;usando direccionamiento relativo por registro
    mov DI, [BX+202h]
    
    int 20h

