.MODEL small
.RADIX 16
ficha_a  equ 'O'
ficha_b  equ 'X'
.STACK
.DATA
usac     db "Universidad de San Carlos de Guatemala",0a,"$"
facultad db "Facultad de Ingenieria",0a,"$"
curso    db "Arquitectura de Computadoras y Ensambladores 1",0a,"$"
semestre db "Segundo Semestre 2023",0a,"$"
titulo   db 0a,"                  EJEMPLO",0a,"                  =======",0a,0a,"$"
menu0    db "Elija una opcion:",0a, " a. Jugar",0a, " s. Cargar",0a, " d. Salir",0a,"$"
mensaje_nombre_a db "Escriba el nombre del jugador 1: $"
mensaje_nombre_b db "Escriba el nombre del jugador 2: $"
nl       db 0a,"$"
mensaje_jugar    db "Ingrese la columna o 'w' para guardar: $"
buffer_nombre db 20,00
              db 20 dup (00)
nombre_a      db 00
              db 20 dup (00)
nombre_b      db 00
              db 20 dup (00)
tablero       db 2a dup (00)
ficha_actual  db ficha_a
mensaje_ficha db " (a)",0a,"$"
encabezado_tablero db "  A   S   D   F   J   K   L  ",0a
                   db " ___ ___ ___ ___ ___ ___ ___ ",0a,"$"
antes_de_fila      db "| $"
entre_columnas     db " | $"
pie_de_tablero     db "'---'---'---'---'---'---'---'",0a,"$"
nombre_guardar  db 0c dup (00),00 
extension_guardar db ".SAV",00
buffer_entrada db 0ff,00
               db 0ff dup (00)
mensaje_guardar db "Escriba el nombre sin extension del archivo: $"
handle_guardar dw 0000
numero db 06 dup (30)
negativo db 00
.CODE
.STARTUP
		mov DX, offset usac
		mov AH, 09
		int 21
		mov DX, offset facultad
		mov AH, 09
		int 21
		mov DX, offset curso
		mov AH, 09
		int 21
		mov DX, offset semestre
		mov AH, 09
		int 21
		mov DX, offset titulo
		mov AH, 09
		int 21
		;;
menu_principal:
		mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset menu0
		mov AH, 09
		int 21
		;;
		mov AH, 08
		int 21
		;;
		cmp AL, 'a'
		je jugar
		jmp fin
		;; - Pedir nombres [OK]
jugar:
		mov DX, offset mensaje_nombre_a
		mov AH, 09
		int 21
		mov DX, offset buffer_nombre
		mov AH, 0a
		int 21
		;; leímos la cadena
		mov DI, offset nombre_a
		call copiar_cadena
		;;
		mov DX, offset nl
		mov AH, 09
		int 21
		;;
		mov DX, offset mensaje_nombre_b
		mov AH, 09
		int 21
		mov DX, offset buffer_nombre
		mov AH, 0a
		int 21
		;;
		mov DI, offset nombre_b
		call copiar_cadena
		;;
		mov DX, offset nl
		mov AH, 09
		int 21
		;;; imprimir el primer nombre
		;
		;
		;mov BX, 0001
		;mov CX, 0000
		;mov CL, [nombre_a]
		;mov DI, offset nombre_a
		;inc DI
		;mov DX, DI
		;mov AH, 40
		;int 21
		;mov DX, offset nl
		;mov AH, 09
		;int 21
		;;; imprimir el segundo nombre
		;mov BX, 0001
		;mov CX, 0000
		;mov CL, [nombre_b]
		;mov DI, offset nombre_b
		;inc DI
		;mov DX, DI
		;mov AH, 40
		;int 21
		;mov DX, offset nl
		;mov AH, 09
		;int 21
		;
		;
		;; - Poner en columna [OK]
pedir_columna:
		mov DX, offset nl
		mov AH, 09
		int 21
		call imprimir_nombre_y_ficha_actual
		mov DX, offset mensaje_jugar
		mov AH, 09
		int 21
		mov AH, 01
		int 21
		;; AL -> columna
		cmp AL, 'w'
		je guardar_partida
		cmp AL, 'q'
		je menu_principal
		;;
		call pasar_de_id_a_numero
		;; verificar valor retornado
		cmp AL, 06
		ja pedir_columna
		;; AL -> número de columna
		call buscar_vacio_en_columna
		;; DL -> 00 si se logró encontrar un espacio
		cmp DL, 0ff
		je pedir_columna
		;; DI -> dirección de la celda disponible
		;; Se coloca ficha
		mov AL, ficha_actual
		mov [DI], AL
		;;
		mov DX, offset nl
		mov AH, 09
		int 21
		;; - Imprimir tablero [OK]
		call imprimir_tablero
		;; - Cambiar turno    [OK]
		mov AL, [ficha_actual]
		cmp AL, ficha_a
		je cambiar_a_por_b
		;;
		mov AL, ficha_a
		mov [ficha_actual], AL
		jmp pedir_columna
cambiar_a_por_b:
		mov AL, ficha_b
		mov [ficha_actual], AL
		jmp pedir_columna
		;; - Guardar tablero  [OK]
guardar_partida:
		mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset mensaje_guardar
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		;;
		mov DX, offset nl
		mov AH, 09
		int 21
		;; DI <- primer byte del buffer
		mov DI, offset buffer_entrada
		inc DI
		;; DI <- segundo byte, tamaño de cadena leida
		mov AL, [DI]
		cmp AL, 08
		ja guardar_partida
		;;; cadena correcta
		call copiar_y_agregar_extension
		;;
		mov CX, 0000
		mov DX, offset nombre_guardar
		mov AH, 3c
		int 21
		;; AX -> handle
		mov [handle_guardar], AX
		;; Se guardará nombre_a, nombre_b, tablero y ficha actual
		mov BX, [handle_guardar]
		mov CX, 006b
		mov DX, offset nombre_a
		mov AH, 40
		int 21
		;;
		mov AH, 3e
		int 21
		;;
		jmp pedir_columna
		;; - Cargar tablero
		jmp fin
;;
;; imprimir_nombre_y_ficha_actual
;;
imprimir_nombre_y_ficha_actual:
		mov AL, [ficha_actual]
		mov BX, offset mensaje_ficha
		add BX, 02
		mov [BX], AL
		sub BX, 02
		cmp AL, ficha_a
		jne imprimir_nombre_b
		;; imprimir nombre_a
		mov BX, 0001
		mov CX, 0000
		mov CL, [nombre_a]
		mov DX, offset nombre_a
		inc DX
		mov AH, 40
		int 21
		jmp imprimir_ficha
imprimir_nombre_b:
		mov BX, 0001
		mov CX, 0000
		mov CL, [nombre_b]
		mov DX, offset nombre_b
		inc DX
		mov AH, 40
		int 21
imprimir_ficha:
		mov DX, offset mensaje_ficha
		mov AH, 09
		int 21
		ret
;;
;; copiar_y_agregar_extension
;;   ENTRADAS 
;;     DI -> dirección del buffer de entrada
;;     SI -> dirección a donde copiar
;;
copiar_y_agregar_extension:
		mov CX, 0000
		mov CL, 0c
		mov BX, offset nombre_guardar
limpiar_nombre_guardar:
		mov AL, 00
		mov [BX], AL
		inc BX
		loop limpiar_nombre_guardar
		;;
		mov SI, offset nombre_guardar
		mov CX, 0000
		mov CL, [DI]
		inc DI
ciclo_copiar_sin_extension:
		mov AL, [DI]
		mov [SI], AL
		inc DI
		inc SI
		loop ciclo_copiar_sin_extension
		;;;
		mov CX, 0000
		mov CL, 04  ;; ".SAV"
		mov DI, offset extension_guardar
ciclo_copiar_extension:
		mov AL, [DI]
		mov [SI], AL
		inc DI
		inc SI
		loop ciclo_copiar_extension
		ret

;;
;; copiar_cadena - copia una cadena
;;    ENTRADAS: DI -> dirección hacia donde guardar
copiar_cadena:
		;; DI tengo ^
		mov SI, offset buffer_nombre
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
;;
;; pasar_de_id_a_numero - pasa de un id de columna a un número
;;
;; SALIDA:  AL -> número de columna o coordenada X
pasar_de_id_a_numero:
		cmp AL, 'a'
		je retornar_num0
		cmp AL, 's'
		je retornar_num1
		cmp AL, 'd'
		je retornar_num2
		cmp AL, 'f'
		je retornar_num3
		cmp AL, 'j'
		je retornar_num4
		cmp AL, 'k'
		je retornar_num5
		cmp AL, 'l'
		je retornar_num6
		;; valor de error
		mov AL, 0ff
		ret
retornar_num0:
		mov AL, 00
		ret
retornar_num1:
		mov AL, 01
		ret
retornar_num2:
		mov AL, 02
		ret
retornar_num3:
		mov AL, 03
		ret
retornar_num4:
		mov AL, 04
		ret
retornar_num5:
		mov AL, 05
		ret
retornar_num6:
		mov AL, 06
		ret
;;
;; buscar_vacio_en_columna - busca un espacio vacío en la columna indicada
;;
;; ENTRADA: AL -> número de columna o X
;; SALIDA:  DI -> número de fila con espacio disponible
;;          DL -> 00 si se obtuvo un espacio disponible
;;               0ff si no se econtró espacio
buscar_vacio_en_columna:
		;; X en AL , Y en DL -> (AL, DL)
		mov DL, 05
ciclo_buscar_vacio:
		;; índice = 7*DL + AL
		mov DH, AL
		;; 7*DL = AX
		mov AL, 07
		mul DL
		;; 7*DL + DH
		;;  AL  + DH
		add AL, DH
		;; AX -> índice
		mov DI, offset tablero
		add DI, AX
		;; verifico el contenido
		mov AL, [DI]
		cmp AL, 00  ;; verificar si está vacío
		je retorno_buscar_vacio
		dec DL
		mov AL, DH
		cmp DL, 00
		jge ciclo_buscar_vacio
retorno_fallido_buscar_vacio:
		mov DL, 0ff
		ret
retorno_buscar_vacio:
		mov DL, 00
		ret
;;
;; obtener_valor_de_casilla - obtiene el valor de una casilla del tablero
;;
;; ENTRADA: BH -> X
;;          BL -> Y
;; SALIDA:  DL -> valor
obtener_valor_de_casilla:
		;; índice = 7*BL + BH
		;; 7*BL = AX
		mov AL, 07
		mul BL
		;; 7*BL + BH
		;;  AL  + BH
		add AL, BH
		;; AX -> índice
		mov DI, offset tablero
		add DI, AX
		;; obtengo el contenido
		mov DL, [DI]
		ret
;;
;; imprimir_tablero - imprime el tablero del juego
;;
imprimir_tablero:
		mov DX, offset encabezado_tablero
		mov AH, 09
		int 21
		;;
		mov BX,0000
		;; inicialización de contadores
		mov SI, 0006
		xchg SI, CX
ciclo_columnas:
		xchg SI, CX
		mov CX, 0007
		;;
		mov DX, offset antes_de_fila
		mov AH, 09
		int 21
		;;
ciclo_fila:
		call obtener_valor_de_casilla
		cmp DL, 00
		je imprimir_vacia
		cmp DL, ficha_a
		je imprimir_ficha_a
		cmp DL, ficha_b
		je imprimir_ficha_b
imprimir_vacia:
		mov DL, ' '
		mov AH, 02
		int 21
		mov DX, offset entre_columnas
		mov AH, 09
		int 21
		jmp avanzar_en_fila
imprimir_ficha_a:
		mov DL, ficha_a
		mov AH, 02
		int 21
		mov DX, offset entre_columnas
		mov AH, 09
		int 21
		jmp avanzar_en_fila
imprimir_ficha_b:
		mov DL, ficha_b
		mov AH, 02
		int 21
		mov DX, offset entre_columnas
		mov AH, 09
		int 21
		jmp avanzar_en_fila
avanzar_en_fila:
		inc BH
		loop ciclo_fila
		mov DL, 0a
		mov AH, 02
		int 21
		;;
		mov BH, 00
		inc BL
		xchg SI, CX
		loop ciclo_columnas
		;;
		mov DX, offset pie_de_tablero
		mov AH, 09
		int 21
		ret

;; numAstr - convierte un número entero en cadena
;;     Entrada: AX -> numero de entrada
;;     Salida:  [numero] -> el número convertido a cadena
numAstr:                                ;;; Limpiar la cadena
                mov CX, 06h
                mov BX, offset numero
                mov DX, 30h
limpiar:        mov [BX], DL
                inc BX
                loop limpiar
                dec BX                   ;;; Posicionarse en el caracter de las unidades
                cmp AX, 0000h            ;;; Si el número es 0 no hacer nada
                je retorno
		jg unidad
		neg AX
		mov DL, 2d
		mov [numero], DL
unidad:         mov DL,[BX]              ;;; Incrementar las unidades
                inc DL
                mov [BX],DL
                dec AX                   ;;; Decrementar el número de entrada
                mov SI, BX               ;;; Guardar el dato de la posición de las unidades en otro registro
revisar_cifra:  mov DX, 3ah              ;;; Si en las unidades está el caracter 3Ah o :
                cmp [BX], DL
                je incrementa_ant        ;;; Saltar a la parte donde se incrementa la cifra anterior
                mov BX, SI               ;;; Restablecer la posición de las unidades en el registro original
                cmp AX, 0000h            ;;; Si el número de entrada no es 0
                jne unidad               ;;; Volver a incrementar unidades
                jmp retorno              ;;; Si no terminar rutina
incrementa_ant: mov DX, 30h              ;;; Se coloca el caracter '0' en la cifra actual
                mov [BX], DL
                dec BX                   ;;; Se mueve el índice a la cifra anterior
                mov DL, [BX]             ;;; Se incrementa la cifra indexada por BX
                inc DL
                mov [BX], DL
                cmp BX, offset numero    ;;; Si el índice actual no es la direccion de la primera cifra
                jne revisar_cifra        ;;; revisar la cifra anterior para ver si nuevamente hay que incrementarla
                mov BX, SI               ;;; Reestablecer la posición de las unidades en el registro original
                cmp AX, 0000h            ;;; Si el número de entrada no es 0
                jne unidad               ;;; Volver a incrementar unidades
retorno:        ret                      ;;; Si no retornar

fin:
.EXIT
END
