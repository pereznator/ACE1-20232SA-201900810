.MODEL small
.STACK

.DATA
    caracter db 0    ; Variable para almacenar el carácter ingresado
    valor db 0       ; Variable para almacenar el valor asignado
    mensaje_error db "Error: Caracter no valido.", 0

.CODE
.STARTUP
    mov ax, @data
    mov ds, ax

    ; Leer un carácter de la entrada estándar (teclado)
    mov ah, 01
    int 21h
    mov [caracter], al  ; Almacena el carácter ingresado

    ; Comprueba el carácter ingresado
    cmp al, '+'  ; Comprueba si es '+'
    je suma
    cmp al, '-'  ; Comprueba si es '-'
    je resta
    cmp al, '*'  ; Comprueba si es '*'
    je multiplicacion
    cmp al, '/'  ; Comprueba si es '/'
    je division

    ; Si el carácter no es ninguno de los esperados, muestra un mensaje de error
    mov dx, offset mensaje_error
    mov ah, 09h
    int 21h
    jmp salir

suma:
    ; Asigna el valor 1 a la variable
    mov [valor], 1
    jmp mostrar_resultado

resta:
    ; Asigna el valor 2 a la variable
    mov [valor], 2
    jmp mostrar_resultado

multiplicacion:
    ; Asigna el valor 3 a la variable
    mov [valor], 3
    jmp mostrar_resultado

division:
    ; Asigna el valor 4 a la variable
    mov [valor], 4
    jmp mostrar_resultado

mostrar_resultado:
    ; Puedes hacer lo que quieras con el valor asignado (en este caso, lo mostramos)
    mov dl, [valor]  ; Cargar el valor en DL para mostrarlo
    add dl, '0'      ; Convertir el valor en carácter ASCII
    mov ah, 02h      ; Función para mostrar un carácter
    int 21h

salir:
    ; Salir del programa
    mov ah, 4Ch
    int 21h

.EXIT
END
