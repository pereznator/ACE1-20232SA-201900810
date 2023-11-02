    imprimir l2
    CALL limpiarPantalla
    imprimir secion
    ;ingreso del usuario
    imprimir musuario
    xor si,si
    leerUsuario
    ;ingreso de la contraseña
    imprimir mcontra
    xor si, si
    leerpass
    ;imprimir contraA
    ;login
    mov ah, 3dh
    mov al, 0h
    mov dx, offset users
    int 21h
    mov handle, ax
    mov bx, handle
    mov ah, 42h
    mov al, 00h
    mov cx, 0
    mov dx, 0
    int 21h
    e1:
        mov si, 00h
        mov controlpass, 0
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h

        cmp auxcontenidoar[si], '$'
        je errornoexiste
        cmp auxcontenidoar[si], ','
        je e2
        mov al, auxcontenidoar[si]
        mov si, controlusers
        mov usersaved[si], al
        inc controlusers
        inc si
        mov usersaved[si], '$'
        jmp e1
    e2:
        calctamuser
        calctamuserle
        mov si, tamus
        cmp tamarch, si
        jz e3
        jne e4
    e3:
        xor si, si
    e6:
        mov al, usersaved[si]
        cmp al, '$'
        je e7
        cmp usering[si], al
        jne e4
        inc si
        jmp e6
    e4:
        mov si, 00h
        mov controlusers, 0
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], 0dh
        je e5
        jmp e4
    e5:
        mov si, 00h
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], '$'
        je e1
        cmp auxcontenidoar[si], 0ah
        je e5
        mov controlusers, 0
        mov al, auxcontenidoar[si]
        mov si, controlusers
        mov usersaved[si], al
        inc controlusers
        inc si
        mov usersaved[si], '$'
        jmp e1
    e7:
        mov si, 00h
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h

        cmp auxcontenidoar[si], '$'
        je errorpass
        cmp auxcontenidoar[si], 0dh
        je e8
        cmp auxcontenidoar[si], 0ah
        je e8
        mov al, auxcontenidoar[si]
        mov si, controlpass
        mov passsaved[si], al
        inc controlpass
        inc si
        mov passsaved[si], '$'
        jmp e7
    e8:
        calctampasss
        calctampass
        mov si, tampass
        cmp tamarch, si
        je e9
        jne e10
    e9:
        xor si, si
    e12:
        mov al, passsaved[si]
        cmp al, '$'
        je ingresarsistema
        cmp passing[si], al
        jne e10
        inc si
        jmp e12
    e10:
        mov si, 00h
        mov controlpass, 0
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], ','
        je e11
        cmp auxcontenidoar[si], '$'
        je errorpass
        jmp e10
    e11:
        mov si, 00h
        mov ah, 3fh
        mov bx, handle
        lea dx, auxcontenidoar
        mov cx, 1
        int 21h
        cmp auxcontenidoar[si], '$'
        je e7
        cmp auxcontenidoar[si], ','
        je e11
        mov controlpass, 0
        mov al, auxcontenidoar[si]
        mov si, controlpass
        mov passsaved[si], al
        inc controlpass
        inc si
        mov passsaved[si], '$'
        jmp e7