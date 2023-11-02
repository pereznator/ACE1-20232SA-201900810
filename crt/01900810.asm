.RADIX 16
.MODEL small 
.STACK
.DATA
    mensajeInicial db "Ingresar un numero de tres digitos: ",0a,"$"
    num2 db 00
    num3 db 00
    tamanio db ?
    archivo_nombre db "FINAL.ACE",00
    num1 db 00
.CODE 
.STARTUP

    mov dx, offset mensajeInicial
    mov ah, 09
    int 21

    xor ax, ax

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h                 ; Leer un carácter desde la entrada estándar
    mov num1, al            ; Guardar valor un num1
    
    sub al, 30h             ; Convierte el carácter ASCII en número (de '0' a 0)
    mov ah, 0               ; Limpia el registro AH (parte alta de AX)
    mov bl, 64h              ; Carga el valor 100 en el registro BL
    mul bl                  ; Multiplica AL por BL (AL = AL * BL)
    mov tamanio, al

    xor ax, ax

    mov ah, 01h
    int 21h
    mov num2, al
    
    sub al, 30h
    mov ah, 0
    mov bl, 0ah             ; Cargar valor 10 en el registro BL
    mul bl                  ; Multiplicar al por bl (al = al * bl)
    mov cl, tamanio         ; Caregar el valor de tamanio en cl
    add cl, al              ; Sumar cl con al 
    mov tamanio, cl         ; guardar nuevo valor de tamanio
    
    xor ax, ax
    
    mov ah, 01h
    int 21h
    mov num3, al

    sub al, 30h
    mov ah, 0
    mov bl, tamanio
    add al, bl
    mov tamanio, al

    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

  escribir_en_archivo:
		mov AH, 3d
		mov AL, 02
		mov DX, offset archivo_nombre
		int 21
		jc crear_archivo
		jmp escribir_contenido
  crear_archivo:
		mov AH, 3c
		mov CX, 0000
		mov DX, offset archivo_nombre
		int 21

  escribir_contenido:
		; posicionar en el final del archivo
		mov BX, AX   ; handle
		mov AL, 02
		mov CX, 0000
		mov DX, 0000
		mov AH, 42
		int 21

    mov bl, tamanio
    mov al, 00

  ciclo_escribir_archivo:
    cmp al, 00
    je escribir_num1
    cmp al, 01
    je escribir_num2
    jmp escribir_num3

  escribir_num1:

		;; guardar el usuario
		mov AH, 40
		mov CX, 0001
		mov DX, offset num1
		int 21

    mov al, 01
    dec bl

    cmp bl, 00
    je cerrar_archivo
    jmp ciclo_escribir_archivo

  escribir_num2:

    mov AH, 40
		mov CX, 0001
		mov DX, offset num2
		int 21

    mov al, 02
    dec bl

    cmp bl, 00
    je cerrar_archivo
    jmp ciclo_escribir_archivo
  
  escribir_num3:

    mov AH, 40
		mov CX, 0001
		mov DX, offset num3
		int 21

    mov al, 00
    dec bl

    cmp bl, 00
    je cerrar_archivo
    jmp ciclo_escribir_archivo


  cerrar_archivo:
		;; cerrar archivo
		mov AH, 3e
		int 21

    fin: 

.EXIT
END 