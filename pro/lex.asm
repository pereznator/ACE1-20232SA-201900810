JUGADOR_CARRIL equ 01
JUGADOR_ACERA  equ 02
ACERA          equ 03
CARRIL         equ 04
CARRO          equ 05
CAMION         equ 06
.MODEL small
.RADIX 16
.STACK
.DATA
vidas    db "O  O  O$"
x_elemento dw 0000
y_elemento dw 0000
coordenadas_jugador dw 0000
coordenada_actual   dw 0000
sprite_jugador db 00, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 00, 05, 05, 00, 00, 05 
               db 00, 05, 05, 05, 05, 05, 05, 00 
               db 05, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 05, 05, 05, 05, 00, 00 
               db 00, 00, 05, 00, 00, 05, 00, 00 
               db 00, 05, 05, 00, 00, 05, 05, 00 
sprite_jugador_carril db 13, 13, 13, 05, 05, 13, 13, 13 
                      db 13, 13, 13, 05, 05, 13, 13, 05 
                      db 13, 05, 05, 05, 05, 05, 05, 13 
                      db 05, 13, 13, 05, 05, 13, 13, 13 
                      db 13, 13, 13, 05, 05, 13, 13, 13 
                      db 13, 13, 05, 05, 05, 05, 13, 13 
                      db 13, 13, 05, 13, 13, 05, 13, 13 
                      db 1f, 05, 05, 13, 1f, 05, 05, 13 
sprite_jugador_acera db 17, 17, 17, 05, 05, 17, 17, 17 
                     db 17, 17, 17, 05, 05, 17, 17, 05 
                     db 17, 05, 05, 05, 05, 05, 05, 17 
                     db 05, 17, 17, 05, 05, 17, 17, 17 
                     db 17, 17, 17, 05, 05, 17, 17, 17 
                     db 17, 17, 05, 05, 05, 05, 17, 17 
                     db 17, 17, 05, 1a, 17, 05, 17, 17 
                     db 17, 05, 05, 17, 17, 05, 05, 17 
sprite_carril  db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 1f, 1f, 13, 13, 1f, 1f, 13, 13 
sprite_banqueta db 17, 17, 17, 17, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 17, 17, 17, 17, 17 
mapa_objetos db 3e8 dup (00)
.CODE
.STARTUP
		;; ingreso al modo de video 13h
		mov AL, 13
		mov AH, 00
		int 10
		;; ...
		;;
		mov DH, 00
		mov DL, 10
		mov BH, 00
		mov AH, 02
		int 10
		;;
		mov DX, offset vidas
		mov AH, 09
		int 21
		;; ...
		mov AL, 00
		mov AH, 01
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 01
		mov AH, 01
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 02
		mov AH, 01
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 00
		mov AH, 02
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 02
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 02
		mov AH, 02
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 00
		mov AH, 03
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 03
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 02
		mov AH, 03
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 00
		mov AH, 04
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 04
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 02
		mov AH, 04
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 03
		mov BL, JUGADOR_CARRIL
		call colocar_en_mapa
		;;
		call pintar_mapa
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
;; pintar_sprite - pinta el sprite en la posición especificada en memoria
;; ENTRADA:
;;   BX -> datos del sprite a pintar
pintar_sprite:
		mov SI, [x_elemento]
		mov DI, [y_elemento]
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
		mov SI, [x_elemento]
		xchg BP, CX
		loop ciclo_filas
		ret
;; colocar_en_mapa -
;; ENTRADA:
;;  AL -> x del elemento
;;  AH -> y del elemento
;;  BL -> código del elemento
colocar_en_mapa:
		push AX    ;; guardar las posiciones en la pila
		mov AL, AH
		mov AH, 00
		mov DI, AX
		mov AX, 28 ;; tamaño máximo de x
		mul DI
		;; DX-AX resultado de la multiplicación
		pop DX
		mov DH, 00
		add AX, DX  ;; AX = 28*y + x
		;; índice hacia la memoria del pixel
		mov SI, offset mapa_objetos
		add SI, AX
		mov [SI], BL
		ret
;; obtener_de_mapa -
;; ENTRADA:
;;  AL -> x del elemento
;;  AH -> y del elemento
;; SALIDA:
;;  BL -> código del elemento
obtener_de_mapa:
		push AX    ;; guardar las posiciones en la pila
		mov AL, AH
		mov AH, 00
		mov DI, AX
		mov AX, 28 ;; tamaño máximo de x
		mul DI
		;; DX-AX resultado de la multiplicación
		pop DX
		mov DH, 00
		add AX, DX  ;; AX = 28*y + x
		;; índice hacia la memoria del pixel
		mov SI, offset mapa_objetos
		add SI, AX
		mov BL, [SI]
		ret
;; pintar_mapa - 
pintar_mapa:
		mov AX, 0000
		mov [coordenada_actual], AX
		mov CX, 19
ciclo_filas_mapa:
		xchg BP, CX
		mov CX, 28
ciclo_columnas_mapa:
		mov AX, [coordenada_actual]
		call obtener_de_mapa
		;; ============================
		;; selección de sprite a pintar
		;; ============================
		cmp BL, ACERA
		je pintar_acera
		cmp BL, CARRIL
		je pintar_carril
		cmp BL, JUGADOR_CARRIL
		je pintar_jugador_carril
		jmp ciclo_columnas_mapa_loop
		;; ==============================================
		;; definición de qué sprite pintar para cada caso
		;; ==============================================
pintar_acera:
		mov BX, offset sprite_banqueta
		jmp pintar_sprite_en_posicion
pintar_carril:
		mov BX, offset sprite_carril
		jmp pintar_sprite_en_posicion
pintar_jugador_carril:
		mov BX, offset sprite_jugador_carril
		jmp pintar_sprite_en_posicion
pintar_sprite_en_posicion:
		mov AX, [coordenada_actual]
		mov AH, 08
		mul AH
		mov [x_elemento], AX
		mov AX, [coordenada_actual]
		mov AL, AH
		mov AH, 08
		mul AH
		mov [y_elemento], AX
		push CX
		push BP
		call pintar_sprite
		pop BP
		pop CX
		jmp ciclo_columnas_mapa_loop
ciclo_columnas_mapa_loop:
		mov AX, [coordenada_actual]
		inc AL
		mov [coordenada_actual], AX
		loop ciclo_columnas_mapa
		mov AX, [coordenada_actual]
		mov AL, 00
		inc AH
		mov [coordenada_actual], AX
		xchg BP, CX
		loop ciclo_filas_mapa
		ret
fin:
.EXIT
END
