org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0d

    MOV DH, 10 ;primera fila en la que estara ubicado el cursor
    MOV DL, 20 ;primera columna en la que estara ubicado el cursor

    call modotexto

;Iteracion principal
    ITERAR:
        call movercursor
        MOV CL, [cadena+SI] 
        call escribircaracter
        INC SI 
        INC DL
        INC DI

        CMP DI, 34d 
        JB ITERAR ;Saltara mientras no se haya recorrido toda la cadena

        jmp esperartecla

    modotexto: 
        MOV AH, 0h ;modo texto
        MOV AL, 03h
        INT 10h
        RET
    movercursor:
        MOV AH, 02h
        MOV BH, 0h

        ;comparacion para el primer nombre
        CMP DI, 10d
        JE incrementardh

        ;comparacion para el segundo nombre
        CMP DI, 18d
        JE incrementardh

        ;comparacion para el segundo apellido
        CMP DI, 25d
        JE incrementardh

        INT 10h
        RET
    escribircaracter:
        MOV AH, 0Ah
        MOV AL, CL
        MOV BH, 0h
        MOV CX, 1h
        INT 10h
        RET

    ;Subrutina para el posicionamiento de cada nombre
    incrementardh:
        INC DH
        INC DH
        MOV DL, 19
        RET

    ;Detener la ejecucion con cualquier tecla
    esperartecla:
        MOV AH, 00h
        INT 16h
    exit:
        int 20h



    section .data

    cadena DB 'Franciscoo Javierr Mejiaa Hercules'