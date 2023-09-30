.RADIX 16
.MODEL small
.STACK 
.DATA
mensaje db "HOLA ARQUI 1",0a,"$"
msjPresionoA db "PRESIONASTE A",0a,"$"
msjNoPresionasteA db "NO PRESIONASTE A",0a,"$"
.CODE
.STARTUP
    ;; Obtener direccion de la etiquete mensaje
  mov DX, offset mensaje
  ;; Imprimir el mensaje utilizando la interrucpcion 21
  mov AH, 09
  int 21
  ;; Leer caracter presionado
  mov AH, 01
  int 21
  cmp Al, 'a'
  je siSePresionoA
  jmp noSePresionoA

  siSePresionoA:
    mov DX, offset msjPresionoA
    mov AH, 09
    int 21
    jmp fin

  noSePresionoA:
    mov DX, offset msjNoPresionasteA
    mov AH, 09
    int 21

  fin:


.EXIT
END
