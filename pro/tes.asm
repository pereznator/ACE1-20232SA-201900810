.MODEL small
;.RADIX 16
.STACK
.DATA
    mensaje1 db "Mensaje 1 - Presionar Enter en 3 segundos", 0
    mensaje2 db "Presionar Enter para finalizar", 0

.CODE
.STARTUP

    ; Muestra mensaje 1
    mov dx, offset mensaje1
    mov ah, 09h
    int 21h

    ; Espera 3 segundos
    mov ah, 86h
    mov cx, 3000
    int 15h

    ; Borra la pantalla
    mov ah, 06h
    mov al, 0
    mov bh, 07h
    mov cx, 0
    mov dx, 184Fh
    int 10h

    ; Muestra mensaje 2
    mov dx, offset mensaje2
    mov ah, 09h
    int 21h

    ; Espera la presión de Enter
    mov ah, 01h
    int 21h
    cmp al, 0Dh
    jne $-1

.EXIT
END
