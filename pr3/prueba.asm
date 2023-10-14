.MODEL small
.STACK 100h

.DATA
filename db "AYUDA.txt",0
buffer db 512 dup(0)
newline db 10, 13, "$"
group_size equ 20
key_buffer db 1

.CODE
.STARTUP
    mov ax, @data
    mov ds, ax

    ; Abrir el archivo en modo lectura
    mov ah, 3Dh
    mov al, 0
    lea dx, filename
    int 21h
    jc error_exit
    mov bx, ax  ; bx contiene el identificador del archivo abierto

print_loop:
    ; Leer 20 líneas del archivo
    mov ah, 3Fh
    mov cx, group_size * 80  ; Leer group_size líneas (cada línea de 80 caracteres)
    mov dx, offset buffer
    mov bx, bx  ; bx contiene el identificador del archivo abierto
    int 21h
    jc error_exit

    ; Imprimir las líneas leídas
    mov dx, offset buffer
    call print_lines

    ; Esperar a que el usuario presione 'n' o 'q'
wait_for_input:
    mov ah, 1
    mov dx, offset key_buffer
    int 21h
    cmp byte ptr [key_buffer], 'n'
    je print_loop  ; Si se presiona 'n', continuar imprimiendo
    cmp byte ptr [key_buffer], 'q'
    je exit_program  ; Si se presiona 'q', salir del programa
    jmp wait_for_input

print_lines:
    ; Imprime las líneas en el buffer
    mov si, 0  ; Inicializar índice de buffer
print_line_loop:
    ; Leer un byte del buffer
    mov al, [dx+si]

    ; Si llegamos al final del buffer, salir
    cmp al, '$'
    je print_line_end

    ; Imprimir el carácter
    mov ah, 0Eh
    int 10h

    ; Siguiente byte
    inc si
    jmp print_line_loop

print_line_end:
    ; Imprimir una nueva línea
    mov ah, 09h
    lea dx, newline
    int 21h
    ret

error_exit:
    ; Manejar errores de archivo
    mov ah, 09h
    lea dx, filename_error_msg
    int 21h

exit_program:
    ; Cerrar el archivo y salir del programa
    mov ah, 3Eh
    int 21h
    mov ah, 4Ch
    int 21h

.DATA
filename_error_msg db "Error al abrir el archivo.", 10, 13, "$"

.EXIT
END