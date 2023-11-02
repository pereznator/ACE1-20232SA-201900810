.radix 16
.model small
.stack 
.data
    nombre_archivo db "USRS.ACE",0
    bufer db 2Fh dup (0) ; Búfer para almacenar un registro de usuario
    usuario_nombre db 14 dup (0)
    usuario_contra db 19 dup (0)
    usuario_tipo db 0
    usuario_bloqueado db 0

.code
.startup

    ; Abrir el archivo para lectura
    mov ah, 3Dh
    lea dx, nombre_archivo
    int 21h
    mov bx, ax ; Manejador del archivo

leer_siguiente_registro:
    ; Leer el contenido del archivo (un registro) en el bufer
    mov ah, 3Fh
    mov cx, 2Fh ; Tamaño de un registro
    mov dx, offset bufer
    int 21h

    ; Verificar si se llegó al final del archivo
    or ax, ax
    jz fin_lectura

    ; Copiar los campos de la estructura desde el bufer
    lea si, bufer
    lea di, usuario_nombre
    mov cx, 14
    rep movsb

    lea si, bufer + 14
    lea di, usuario_contra
    mov cx, 19
    rep movsb

    mov al, [si]
    mov usuario_tipo, al

    mov al, [si + 1]
    mov usuario_bloqueado, al

    ; Aquí puedes trabajar con los datos de usuario (nombre, contraseña, tipo, bloqueado)

    mov BX, 0001
    mov CX, 0000
    mov CL, [usuario_nombre]
    mov DX, offset usuario_nombre
    inc DX
    mov AH, 40
    int 21

    ; Continuar leyendo más estructuras si es necesario
    jmp leer_siguiente_registro

fin_lectura:
    ; Cerrar el archivo
    mov ah, 3Eh
    mov bx, ax ; Manejador del archivo
    int 21h

    ; Continuar con el programa

    ; ...

.exit
end
