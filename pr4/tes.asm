.model small
.STACK
.data
    num1 db ?   ; Definir el primer número
    num1_2 db ?
    num2 db ?   ; Definir el segundo número
    result db ?  ; Variable para almacenar el resultado
    numero db 6 dup(' '),'$'
    aux dw 10
    mensaje1 db "Ingrese el primer numero: $"
    mensaje2 db "Ingrese el segundo numero: $"

.code
    mov ax, @data   ; Inicializar el segmento de datos
    mov ds, ax

    ; Pide al usuario que ingrese el primer número
    mov ah, 09h				;; INT DOS
    lea dx, mensaje1		;; MSJ a imprimir
    int 21h					;; INT

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h                 ; Leer un carácter desde la entrada estándar

    sub al, 30h             ; Convierte el carácter ASCII en número (de '0' a 0)
    mov ah, 0               ; Limpia el registro AH (parte alta de AX)
    mov bl, 10              ; Carga el valor 10 en el registro BL
    mul bl                  ; Multiplica AL por BL (AL = AL * BL)
    mov num1, al			;; Guardo en num1

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h                 ; Leer un carácter desde la entrada estándar

    sub al, 30h             ; Convierte el carácter ASCII en número (de '0' a 0)
    mov ah, 0000h           ; Limpia el registro AH (parte alta de AX)
    mov bl, num1
    add al, bl              ; Multiplica AL por BL (AL = AL * BL)
    mov num1, al			;; Guardo en num1

    mov ah, 09h
    lea dx, mensaje2
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, 30h     ; Convertir el carácter ASCII en número
    mov num2, al

    mov ah, 0000h
    mov al, 0000h
    mov al, num1   ; Cargar el primer número en AL
    div num2   ; Sumar el segundo número a AL
    mov result, al  ; Almacenar el resultado en la variable resultado

numAstr:
    mov al, result 
    mov si, 6  
loop_nAs:
    dec si
    xor dx, dx       
    div word ptr [aux] 
    add dl, '0'      
    mov byte ptr numero[si], dl
    test al, al      
    jnz loop_nAs
    mov ah, 9
    lea dx, numero   
    int 21h


.EXIT
end
