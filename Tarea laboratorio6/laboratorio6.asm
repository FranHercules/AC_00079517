org 	100h

	section	.text

    call 	LeerCadena ;Sub rutina para leer la cadena
	call	EscribirCadena ;Sub rutina para escribir la cadena

    int 	20h

    section	.data

    clave	db	"clave", "$"
    msg1	db	"BIENVENIDO", "$"
    msg2	db	"INCORRECTO", "$"

    EsperarTecla:
        mov     AH, 07h         
        int     21h
        ret

    LeerCadena:
        xor     SI, SI          ; SI = 0
        xor     DI, DI
        while:  
            call    EsperarTecla    ; retorna un caracter en AL
            cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
            je      exit            ; si AL == EnterKey, saltar a exit
            call    comparar ;validador de la clave
            mov     [300h+SI], AL   ; guardar caracter en memoria
            inc     SI              ; SI++
            jmp     while           ; saltar a while
    exit:
        mov byte [300h+SI], "$"	; agregar $ al final de la cadena
        ret

    comparar:
        cmp [clave + SI], AL
        je suma
        ret
    suma:
        inc DI
        ret
    EscribirCadena:
        cmp DI, SI
        je bienvenido ;escribir bienvenido
        jne incorrecto ;escribir incorrecto
        ret

    bienvenido:
        mov 	AH, 09h
        mov 	DX, msg1
        int 	21h
        ret

    incorrecto:
        mov 	AH, 09h
        mov 	DX, msg2
        int 	21h
        ret