.RADIX 16
.MODEL small
.STACK
.DATA
  ; DECLARACION DE DATA PARA EL PROGRAMA
  usac  db "Universidad de San Carlos de Guatemala",0a,"$"
  facultad db "Facultad de Ingenieria",0a,"$"
  curso    db "Arquitectura de Computadoras y Ensambladores 1",0a,"$"
  seccion db "Seccion A",0a,"$"
  semestre db "Segundo Semestre 2023",0a,"$"
  aux dw 10
  nombre db 0a,"Nombre: Jorge Antonio Perez Ordonez",0a,"$"
  carnet db "Carnet: 201900810",0a,"$"
  proyecto db "Proyecto 2",0a,"$"
  terminado db "TERMINADO",0a,"$"
.CODE 
.STARTUP
    ; INICIO DE CODIGO DEL PROGRAMA

  imprimirMensajeInicial:
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
    mov DX, offset proyecto
    mov AH, 09
    int 21

  esperar5Segundos:
    mov ah, 86h        ; Función 86h de la interrupción 15h (esperar 1 segundo)
    mov cx, 7h          ; Esperar 5 segundos
    int 15h

  modoDeVideo:
    mov al, 13
    mov ah, 00
    int 10

    mov dx, offset terminado
    mov ah, 09
    int 21

  fin:

.EXIT 
END 