.MODEL small
.STACK

.DATA
    numero db 0          ; Variable para almacenar el número ingresado por el usuario
    resultado dw 1       ; Variable para almacenar el resultado del factorial
    mensaje db "Ingrese un número entre 01 y 04: $"
    mensaje_resultado db "Resultado: $"
    mensaje_operacion db "0!=1", 0
    msjError db "Error: Número fuera de rango. $"

.CODE
.STARTUP
    mov ax, @data
    mov ds, ax

    ; Imprimir mensaje para ingresar un número
    mov dx, offset mensaje
    mov ah, 09h
    int 21h

    ; Leer el número ingresado
    mov ah, 01
    int 21h
    sub al, '0'  ; Convertir el carácter ASCII a número

    ; Comprobar si el número está dentro del rango
    cmp al, 1
    jl error
    cmp al, 4
    jg error

    ; Calcular el factorial y mostrar las operaciones
    mov cx, 1   ; Inicializa el contador en 1
    mov ax, 1   ; Inicializa el resultado en 1

imprimir_resultados:
    ; Mostrar la operación actual
    mov dx, offset mensaje_operacion
    mov ah, 09h
    int 21h

    ; Mostrar el resultado actual
    mov dx, offset mensaje_resultado
    mov ah, 09h
    int 21h

    ; Convertir el resultado a cadena y mostrarlo
    call mostrar_resultado

    ; Calcular el siguiente resultado
    mul cx
    inc cx

    ; Mostrar coma y espacio para la siguiente operación
    mov dx, offset ", $"
    mov ah, 09h
    int 21h

    ; Terminar si hemos calculado el factorial completo
    ; Terminar si hemos calculado el factorial completo
; Terminar si hemos calculado el factorial completo
    mov al, cl  ; Cargamos el valor de cl (8 bits) en al (8 bits)
    cmp ax, cx  ; Comparamos los valores de 8 bits en ax y cx
    jle imprimir_resultados



salir:
    ; Salir del programa
    mov ah, 4Ch
    int 21h

error:
    ; Mostrar mensaje de error si el número está fuera del rango
    mov dx, offset msjError
    mov ah, 09h
    int 21h
    jmp salir

mostrar_resultado:
    ; Función para mostrar el valor de AX como una cadena
    push ax
    mov bx, 10
    xor cx, cx
    mov di, offset mensaje_resultado + 10  ; Posición para escribir la cadena de resultado

convertir_a_cadena:
    xor dx, dx
    div bx
    add dl, '0'
    mov [di], dl
    dec di
    inc cx
    test ax, ax
    jnz convertir_a_cadena

    pop ax
    ret

.EXIT
END
