.RADIX 16
.MODEL small
.STACK
.DATA
     ;DATA IMPORTANTE QUE SE UTIILZARA EN EL CODIGO
  usac  db "Universidad de San Carlos de Guatemala",0a,"$"
  facultad db "Facultad de Ingenieria",0a,"$"
  curso    db "Arquitectura de Computadoras y Ensambladores 1",0a,"$"
  seccion db "Seccion A",0a,"$"
  semestre db "Segundo Semestre 2023",0a,"$"
  nombre db 0a,"Nombre:   Jorge Antonio Perez Ordonez",0a,"$"
  carnet db "Carnet:    201900810",0a,"$"
  practica db "Practica 4",0a,"$"
  presionarEnter db 0a,"Presionar ENTER para continuar...",0a,"$"
  titulo   db 0a,"                  CALCULADORA",0a,"                  ===========",0a,0a,"$"
  menu    db "Elija una opcion:",0a, " 1. Cargar Archivo",0a, " 2. Modo Calculadora",0a, " 3. Factorial", 0a, " 4. Reporte",0a," 5. Salir",0a,"$"
  msjCargarArchivo db "Ingresar la ruta del archivo: ",0a,"$"

  msjError db "Hubo un error.",0a,"$"
  saltoLinea db 0a,"$"

  ;DATA PARA EL ARCHIVO DE TEXTO
  bufferNombre  db 20,00
                db 20 dup (00) ; Buffer para almacenar la ruta del archivo
  rutaArchivo db 00 
              db 20 dup (00)

  ultimos4  db 00
            db 04 dup (00)

  extensionDelArchivo db ".arq",0
  longitudExt equ $ - extensionDelArchivo
  msjExtensioValida db "extension valida",0a,"$"

  msjExtensionError db "La cadena no termina con '.arq'$"

  msjCheckpoint db "Checkpoint",0a,"$"

  ; CONTENIDO DEL ARCHIVO
  bufferContenido db 20,00 
                  db 20 dup (00)

  contenido db 00
            db 20 dup (00)

  msjErrorArchivo db "Error abriendo el archivo",0a,"$"

  ; Calculadora
  msjIngresarNumero db "Ingresar un numero: ",0a,"$"
  msjIngresarOperador db "Ingresar operador: ",0a,"$"
  msjOperadorOIgual db "Ingresar otro operador o '=' para finalizar",0a,"$"
  msjErrorOperador db "No se ingreso un operador valido",0a,"$"

  num1 db ?
  num2 db ?
  result db ?  ; Variable para almacenar el resultado
  numero db 6 dup(' '),'$'
  aux dw 10

  operador db 00

  

.CODE
.STARTUP
;; LOGICA DEL PROGRAMA
  mov DX, offset usac
  mov AH, 09
  int 21
  mov DX, offset facultad
  mov AH, 09
  int 21
  mov DX, offset curso
  mov AH, 09
  int 21
  mov DX, offset seccion
  mov AH, 09
  int 21
  mov DX, offset semestre
  mov AH, 09
  int 21
  mov DX, offset nombre
  mov AH, 09
  int 21
  mov DX, offset carnet
  mov AH, 09
  int 21
  mov DX, offset practica
  mov AH, 09
  int 21
  mov DX, offset presionarEnter
  mov AH, 09
  int 21

  jmp leerEnter

  leerEnter:
    ;; Leer caracter presionado
    mov AH, 00
    int 16h

    cmp AL, 0DH
    jne leerEnter
    jmp imprimirMenu

  imprimirMenu:
    mov DX, offset titulo
    mov AH, 09
    int 21
    mov DX, offset menu
    mov AH, 09
    int 21
    jmp leerOpcion

  leerOpcion:
    mov AH, 01
    int 21
    cmp Al, '1'
    je cargarArchivo
    cmp AL, '2'
    je modoCalculadora
    cmp AL, '5'
    je salir
    jne imprimirMenu


  cargarArchivo:
    ; Mostrar mensaje para ingresar ruta del archivo
    mov DX, offset msjCargarArchivo
    mov AH, 09
    int 21

    ; Mover el buffer que guarda la cadena de la ruta del archivo
    mov DX, offset bufferNombre
		mov AH, 0a
		int 21

    ;; leímos la cadena
    mov DI, offset rutaArchivo
		call copiarCadena

    ; Imprimir salto de linea
    mov DX, offset saltoLinea
		mov AH, 09
		int 21

    ; Obtener utlmos 4 caracteres de la ruta del archivo
    mov DI, offset ultimos4
    call copiarExt

    ; Comparar extension
    mov si, offset ultimos4
    mov di, offset extensionDelArchivo
    mov cx, 5
    call compararExtension

    mov dx, offset msjExtensioValida
    mov ah, 09
    int 21

    jmp imprimirMenu

  
  modoCalculadora:
    mov dx, offset msjIngresarNumero
    mov ah, 09
    int 21

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h                 ; Leer un carácter desde la entrada estándar
    sub al, 30h             ; Convierte el carácter ASCII en número (de '0' a 0)
    mov ah, 0               ; Limpia el registro AH (parte alta de AX)
    mov bl, 10              ; Carga el valor 10 en el registro BL
    mul bl                  ; Multiplica AL por BL (AL = AL * BL)
    mov num1, al

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h                 ; Leer un carácter desde la entrada estándar
    sub al, 30h             ; Convierte el carácter ASCII en número (de '0' a 0)
    mov ah, 0000h           ; Limpia el registro AH (parte alta de AX)
    mov bl, num1
    add al, bl              ; Multiplica AL por BL (AL = AL * BL)
    mov num1, al			      ; Guardo en num1

    mov dx, offset msjIngresarOperador
    mov ah, 09
    int 21

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h
    mov [operador], al

    cmp al, '+'
    je ingresarOtroNumero
    cmp al, '-'
    je ingresarOtroNumero
    cmp al, '*'
    je ingresarOtroNumero
    cmp al, '/'
    je ingresarOtroNumero
    jne errorOp

  ingresarOtroNumero:
    mov dx, offset msjIngresarNumero
    mov ah, 09
    int 21

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h                 ; Leer un carácter desde la entrada estándar
    sub al, 30h             ; Convierte el carácter ASCII en número (de '0' a 0)
    mov ah, 0               ; Limpia el registro AH (parte alta de AX)
    mov bl, 10              ; Carga el valor 10 en el registro BL
    mul bl                  ; Multiplica AL por BL (AL = AL * BL)
    mov num2, al

    mov ah, 01h             ; Interrupción DOS para leer 1 carácter
    int 21h                 ; Leer un carácter desde la entrada estándar
    sub al, 30h             ; Convierte el carácter ASCII en número (de '0' a 0)
    mov ah, 0000h           ; Limpia el registro AH (parte alta de AX)
    mov bl, num2
    add al, bl              ; Multiplica AL por BL (AL = AL * BL)
    mov num2, al			;; Guardo en num1

    mov dl, [operador]

    cmp dl, '+'
    je sumar
    cmp dl, '-'
    je restar
    jne error


    jmp imprimirMenu

  sumar:
    mov ah, 0000h
    mov al, 0000h
    mov al, num1   ; Cargar el primer número en AL
    add al, num2   ; Sumar el segundo número a AL
    mov result, al  ; Almacenar el resultado en la variable resultado
    jmp numAstr

  restar:
    mov ah, 0000h
    mov al, 0000h
    mov al, num1   ; Cargar el primer número en AL
    sub al, num2   ; Sumar el segundo número a AL
    mov result, al  ; Almacenar el resultado en la variable resultado
    jmp numAstr

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

    jmp imprimirMenu

  ; =================>>> Sub rutinas <<<=================
  ; =====================================================

  compararExtension:
    mov al, [si]
    cmp al, [di]
    jne cadenaNoCoinciden
    inc si
    inc di
    loop compararExtension
    ret

  cadenaNoCoinciden:
    mov dx, offset msjExtensionError
    mov ah, 09
    int 21

    jmp salir

  copiarExt:
    mov si, offset rutaArchivo
    mov al, [si]
    sub al, 03

    mov cx, 0000
    mov cl, al
    call incrementarSI

    mov al, 04
    mov [di], al
    inc di

    mov al, [si]
    mov [di], al
    inc si
    inc di

    mov cx, 0000
    mov cl, 04

  cicloCopiarExt:
    mov al, [si]
    mov [di], al 
    inc si
    inc di
    loop cicloCopiarExt
    ret
  
  incrementarSI:
    inc si 
    loop incrementarSI
    ret

  ;; copia una cadena
  ;; ENTRADAS: DI -> dirección hacia donde guardar
  copiarCadena:
    ;; DI tengo ^
    mov SI, offset bufferNombre
    inc SI
    mov AL, [SI]
    mov [DI], AL
    inc SI   ;; moverme a los bytes de la cadena
    inc DI   ;; para guardar esos bytes en el lugar correcto
    ;;
    mov CX, 0000  ;; limpiando CX
    mov CL, AL

  ciclo_copiar_cadena:
		mov AL, [SI]
		mov [DI], AL
		inc SI
		inc DI
		loop ciclo_copiar_cadena
		ret

  guardarOpSuma:
    mov di, offset operador
    mov al, 01
    mov [di], al
    ret 

  guardarOpResta:
    mov di, offset operador
    mov al, 02
    mov [di], al
    ret 
  
  guardarOpMulti:
    mov di, offset operador
    mov al, 03
    mov [di], al
    ret
  
  guardarOpDiv:
    mov di, offset operador
    mov al, 04
    mov [di], al
    ret

  errorOp:
    mov dx, offset msjErrorOperador
    mov ah, 09
    int 21
    jmp salir

  error:
    ; Manejo de errores
    mov dx, offset msjError
    mov ah, 09
    int 21h
    jmp salir

  errorAbrirArchivo:
    mov dx, offset msjErrorArchivo
    mov ah, 09
    int 21
    jmp salir

  salir:
    mov ah, 4Ch ; Código de función para salir del programa en DOS
    int 21h     ; Llamada al sistema DOS

.EXIT
END
