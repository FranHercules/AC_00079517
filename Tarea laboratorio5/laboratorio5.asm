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
        call movercursor ;llamada a mover cursor
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI ; contador para terminar la ejecución del programa al llegar a 10

        CMP DI, 34d ; Comparación de DI con 10d
        JB ITERAR ; si DI es menor a 10, entonces que siga iterando.

        jmp esperartecla ; de caso contrario, que salte a esperar tecla.

    modotexto: 
        ;Similar a usar una función en alto nivel
        ;Modotexto(parametro1)
        ;Donde: parametro1= AL (modo gráfico deseado)
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado
        INT 10h
        RET
    movercursor:
        ;Similar a usar una función en alto nivel
        ;MoverCursor(parametro1, parametro2, parametro3,...)
        ;Donde: Parametro1 = DH (fila del cursor), parametro2 = DL (columna del cursor), parametro 3 = BH (número de página)
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV BH, 0h

        ;comparacion para el primer nombre
        CMP DI, 10d
        JE incrementardh

        ;comparacion para el segundo nombre
        CMP DI, 18d
        JE incrementardh

        ;comparacion para el primer apellido
        CMP DI, 18d
        JE incrementardh

        ;comparacion para el segundo apellido
        CMP DI, 25d
        JE incrementardh

        INT 10h
        RET
    escribircaracter:
        ;Similar a usar una función en alto nivel
        ;EscribirCaracter(parametro1, parametro2, parametro3,...)
        ;Donde: parametro1 = AL (caracter), parametro2 = BH (número de página), parametro3 = BL (estilo del texto en 8 bits)...
        MOV AH, 0Ah ; escribe caracter en pantalla según posición del cursor
        MOV AL, CL ; denotamos el caracter a escribir en pantalla, los valores deben ser según código hexadecimal de tabla ASCII
        MOV BH, 0h ; número de página
        MOV CX, 1h ; número de veces a escribir el caracter
        INT 10h
        RET

    ;Subrutina para el posicionamiento de cada nombre
    incrementardh:
        INC DH
        INC DH
        MOV DL, 19
        RET

    esperartecla:
    ;Se espera que el usuario presione una tecla
        MOV AH, 00h ;espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h
    exit:
        int 20h



    section .data

    cadena DB 'Franciscoo Javierr Mejiaa Hercules'