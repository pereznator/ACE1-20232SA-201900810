.MODEL small
.RADIX 16
.STACK
.DATA
x_jugador dw 0000
y_jugador dw 0000
sprite_jugador db 00, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 00, 05, 05, 00, 00, 05 
               db 00, 05, 05, 05, 05, 05, 05, 00 
               db 05, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 05, 05, 05, 05, 00, 00 
               db 00, 00, 05, 00, 00, 05, 00, 00 
               db 00, 05, 05, 00, 00, 05, 05, 00 
.CODE
.STARTUP
		;; ingreso al modo de video 13h
		mov AL, 13
		mov AH, 00
		int 10
		;; ...
		mov AX, 5d
		mov [x_jugador], AX
		mov AX, 90
		mov [y_jugador], AX
		call pintar_jugador
		;; ...
		;;
infinito:
		jmp infinito
		jmp fin
;; pintar_pixel - pinta un pixel en una posición x, y
;; ENTRADAS:
;;  - SI - x
;;  - DI - y
;;  - CL - color 
;; SALIDA:
pintar_pixel:
		;; DS tiene cierto valor
		;; se preservó DS
		push DS
		;; se coloca la dirección del scanner del modo de video
		mov DX, 0a000
		mov DS, DX
		;;
		mov AX, 140 ;; tamaño máximo de x ;; tamaño máximo de x
		mul DI
		;; DX-AX resultado de la multiplicación
		add AX, SI
		;; índice hacia la memoria del pixel
		mov BX, AX
		mov [BX], CL
		pop DS
		ret
;; pintar_jugador - pinta el jugador en la posición especificada en memoria
;; ENTRADA:
pintar_jugador:
		mov SI, [x_jugador]
		mov DI, [y_jugador]
		mov BX, offset sprite_jugador
		xchg BP, CX
		mov CX, 0000
		mov CL, 08    ;; altura del jugador, 8 en este caso
ciclo_filas:
		xchg BP, CX
		mov CX, 0000
		mov CL, 08    ;; anchura del jugador, 8 en este caso
ciclo_columnas:
		push BX
		push CX
		mov CL, [BX]
		call pintar_pixel
		pop CX
		pop BX
		inc SI
		inc BX
		loop ciclo_columnas
		;; terminó una fila
		;;; incremento y
		inc DI
		;;; reinicio x
		mov SI, [x_jugador]
		xchg BP, CX
		loop ciclo_filas
		ret
fin:
.EXIT
END
