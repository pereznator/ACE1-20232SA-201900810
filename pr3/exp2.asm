.RADIX 16
  ficha_a  equ 'O'
  ficha_b  equ 'X'
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
  presionarEnter db 0a,"Presionar ENTER para continuar...",0a,"$"
  titulo   db 0a,"                  CONNECT 4",0a,"                  =========",0a,0a,"$"
  menu    db "Elija una opcion:",0a, " a. Jugar",0a, " b. Cargar",0a, " c. Ayuda", 0a, " d. Salir",0a,"$"
  tituloCargar db "Que partida quieres cargar?",0a,"$"
  tituloAyuda db "Instrucciones: ",0a,"$"
  menuJuego db "Elegir modo de juego:",0a," a. Jugador vs Jugador",0a," b. Jugador vs PC",0a,"$"
  tituloJugadorVsJugador db "A jugar jug vs jug",0a,"$"
  tituloJugadorVsPC db "A jugar jug vs PC",0a,"$"


  ayuda_file db "AYUDA.txt", 0
  filename_error_msg db "Error al abrir el archivo.", 10, 13, "$"
  buffer db 80 dup(0)  ; Un buffer para almacenar una línea del archivo
  

  ; mensaje_nombre_a db "Escriba el nombre del jugador 1: $"
  ; mensaje_nombre_b db "Escriba el nombre del jugador 2: $"
  ; nl       db 0a,"$"
  ; mensaje_jugar    db "Ingrese la columna: $"
  ; buffer_nombre db 20,00
  ;               db 20 dup (00)
  ; nombre_a      db 00
  ;               db 20 dup (00)
  ; nombre_b      db 00
  ;               db 20 dup (00)
  ; tablero       db 2a dup (00)
  encabezado_tablero db "  A   S   D   F   J   K   L  ",0a
  ;                   db " ___ ___ ___ ___ ___ ___ ___ ",0a,"$"
  antes_de_fila      db "| $"
  entre_columnas     db " | $"
  pie_de_tablero     db "'---'---'---'---'---'---'---'",0a,"$"
  ; ficha_actual  db ficha_a
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

    cmp Al, 'a'
    mov DX, offset menuJuego
    mov AH, 09
    int 21
    je jugar
    
    cmp AL, 'b'
    je cargar
    
    cmp AL, 'c'
    je ayuda
    
    cmp AL, 'd'
    je fin
    
    jne leerOpcion

  jugar:
    mov AH, 01
    int 21
    cmp AL, 'a'
    je jugadorVsJugador
    cmp AL, 'b'
    je jugadorVsPc
    jne jugar

    jugadorVsJugador:
      mov DX, offset tituloJugadorVsJugador
      mov AH, 09
      int 21
      jmp imprimirmenu

    jugadorVsPc:
      mov DX, offset tituloJugadorVsPC
      mov AH, 09
      int 21
      jmp imprimirmenu

  cargar:
    mov DX, offset tituloCargar
    mov AH, 09
    int 21
    jmp imprimirMenu

  ayuda:
    mov DX, offset tituloAyuda
    mov AH, 09
    int 21

    ; Abrir el archivo de ayuda
    mov ah, 3Dh       ; Función para abrir archivo
    lea dx, ayuda_file
    int 21h
    jc error_exit     ; Manejar errores de archivo
    mov bx, ax        ; bx contiene el identificador del archivo abierto

    jmp print_help

  print_help:
    ; Imprimir 20 líneas del archivo
    mov cx, 20         ; Número de líneas a imprimir por iteración
  print_line_loop:
    mov ah, 3Fh       ; Función para leer desde el archivo
    mov dx, offset buffer
    mov al, cl         ; cl contiene el número de líneas a leer
    xor ch, ch         ; ch se usa como contador de líneas leídas
    mov bx, bx         ; bx contiene el identificador del archivo abierto
    int 21h
    jc error_exit      ; Manejar errores de archivo

    ; Imprimir las líneas leídas
    mov dx, offset buffer
    call print_lines

    ; Incrementar el contador de líneas leídas
    inc ch

    ; Si aún hay líneas en el archivo y no hemos leído suficientes, continuar
    cmp ch, cl
    jl print_line_loop

    ; Esperar a que el usuario presione 'n' o 'q'
    mov ah, 01
    int 21h
    cmp al, 'n'
    je print_help  ; Si se presiona 'n', mostrar el siguiente grupo de líneas
    cmp al, 'q'
    je imprimirMenu  ; Si se presiona 'q', volver al menú principal
    jmp print_help

  error_exit:
    ; Manejar errores de archivo
    mov ah, 09h
    lea dx, filename_error_msg
    int 21h
  
  fin:
    mov AH, 4Ch
    int 21h

.EXIT 
END 