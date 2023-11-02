JUGADOR_CARRIL equ 01
JUGADOR_ACERA  equ 02
ACERA          equ 03
CARRIL         equ 04
CARRO          equ 05
CAMIONI         equ 06
CAMIOND         equ 07

CARRO1         equ 08


USUARIO_NORMAL         equ 01
USUARIO_ADMIN          equ 02
USUARIO_ADMIN_ORIGINAL equ 03

TAM_NOMBRE equ 14
TAM_CONTRA equ 19

NO_BLOQUEADO equ 00
BLOQUEADO    equ 01

.MODEL small
.RADIX 16
.STACK
.DATA
  usac  db "Universidad de San Carlos de Guatemala",0a,"$"
  facultad db "Facultad de Ingenieria",0a,"$"
  curso    db "Arquitectura de Computadoras y Ensambladores 1",0a,"$"
  seccion db "Seccion A",0a,"$"
  semestre db "Segundo Semestre 2023",0a,"$"
  encabezado_nombre db 0a,"Nombre:   Jorge Antonio Perez Ordonez",0a,"$"
  encabezado_carnet db "Carnet:    201900810",0a,"$"
  proyecto db "Proyecto 2",0a,"$"

vidas3    db "O  O  O$"
vidas2    db "O  O  *$"
vidas1    db "O  *  *$"
vidas0    db "*  *  *$"

vidas_restantes db 03

x_elemento dw 0000
y_elemento dw 0000

coordenadas_jugador dw 1714h
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


sprite_carro    db 13, 13, 13, 13, 13, 13, 13, 13 
                db 13, 0c, 0c, 0c, 0b, 0f, 13, 13 
                db 13, 0c, 0c, 0c, 0b, 0b, 13, 13 
                db 13, 0c, 0c, 0c, 0c, 0c, 0c, 0c 
                db 00, 00, 0c, 0c, 0c, 00, 00, 0c 
                db 00, 00, 0c, 0c, 0c, 00, 00, 13 
                db 13, 13, 13, 13, 13, 13, 13, 13 
                db 1f, 1f, 13, 13, 1f, 1f, 13, 13  

sprite_camion_izquierdo   db 13, 13, 13, 13, 13, 13, 13, 13 
                          db 13, 0e, 0e, 0e, 0e, 0e, 0e, 0e 
                          db 13, 0e, 0f, 0f, 0f, 0f, 0f, 0f 
                          db 13, 0e, 0f, 0f, 0f, 0f, 0f, 0f 
                          db 13, 0e, 0f, 0f, 0f, 0f, 0f, 0f 
                          db 13, 0e, 0e, 00, 00, 0e, 0e, 0e 
                          db 13, 13, 13, 00, 00, 13, 13, 13 
                          db 1f, 1f, 13, 13, 1f, 1f, 13, 13 

sprite_camion_derecho     db 13, 13, 13, 13, 13, 13, 13, 13 
                          db 0e, 0e, 04, 04, 0b, 0f, 13, 13 
                          db 0f, 0f, 04, 04, 0b, 0b, 13, 13 
                          db 0f, 0f, 04, 04, 04, 04, 13, 13 
                          db 0f, 0f, 04, 04, 04, 04, 13, 13 
                          db 00, 00, 0e, 13, 13, 13, 13, 13 
                          db 00, 00, 13, 13, 13, 13, 13, 13 
                          db 1f, 1f, 13, 13, 1f, 1f, 13, 13 
                          

posicion_carro dw 0000

; posiciones_vehiculos_arreglo db 21 dup(00)
posiciones_vehiculos_arreglo db 00, 26, 0ah, 1eh, 01, 09, 27, 0fh, 00, 15, 08, 22, 0bh, 0ch, 26, 02, 20, 0ah, 00, 19, 0ah
indice_vehiculos_derecha db 00

mapa_objetos db 3e8 dup (00)

opcion_principal_1  db "F1  Iniciar sesion$"
opcion_principal_2  db "F2  Registro$"
opcion_principal_3  db "F3  Salir$"

opcion1  db "F1  Jugar$"
opcion2  db "F2  Generar puntaje$"
opcion3  db "F3  Ordenar puntajes$"
opcion4  db "F4  Salir$"

pausa_opcion_1 db "F1   Continuar$"
pausa_opcion_2 db "F2   Salir$"

mensaje_fin_de_juego db "FIN DEL JUEGO$"

cadena_pedir_nombre db "Escriba su nombre: $"
cadena_pedir_contra db "Escriba su clave: $"

admin_nombre db "jperez",00,00,00,00,00,00,00,00,00,00,00,00,00,00
; admin_nombre db "jperez"
admin_contra db "201900810A*",00,00,00,00,00,00,00,00,00,00,00,00,00,00

test_nombre db "antonio",00,00,00,00,00,00,00,00,00,00,00,00,00

;; ESTRUCTURA USUARIO -> 2f bytes
usuario_nombre    db 14 dup (00)
usuario_contra    db 19 dup (00)
usuario_tipo      db         00
usuario_bloqueado db         00

;; VARIABLES PARA INICIO DE SESION
login_usuario_nombre db 14 dup (00)
login_usuario_contra db 19 dup (00)

login_buffer db 2Fh dup (00)  ; Bufer para almacenar una estructura de usuario

cantidad_de_registros_usuarios dw 0000

;; ESTRUCTURA JUEGO   -> 06 bytes
juego_cod_usuario dw 0000
juego_tiempo      dw 0000
juego_puntos      dw 0000

;; COPIA ESTRUCTURA
juego_tmp_cod_usuario dw 0000
juego_tmp_tiempo      dw 0000
juego_tmp_puntos      dw 0000

buffer_entrada db 0ff,00
               db 0ff dup (00)

usuarios_archivo db "USRS.ACE",00
juegos_archivo   db "PUNTOS.ACE",00

cadena_limpiar db "                                       $" 

handle_a dw 0000
handle_b dw 0000
tam_archivo_origen dw 0000
un_byte  db 00
copia_puntos db "PUNTOS02.ACE",00

indice_usuarios       dw 0000
indice_burbuja        dw 0000
cantidad_de_registros dw 0000
hubo_intercambio      db 00
numero_a              dw 0000
numero_b              dw 0000

numero               db  '000000','$'

cadena_mostrar_cod_usuario db 'Codigo de usuario:   $'
cadena_mostrar_cod_puntos  db 'Puntos obtenidos:    $'
cadena_mostrar_cod_tiempo  db 'Tiempo transcurrido: $'
cadena_separador           db '=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=$'
cadena_ayuda               db '-- presiona cualquier tecla --$'
cadena_ayuda_fin           db '-- el fin, presiona cualquier tecla --$'

fila_texto db 00
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
  mov DX, offset seccion
  mov AH, 09
  int 21
  mov DX, offset semestre
  mov AH, 09
  int 21
  mov DX, offset encabezado_nombre
  mov AH, 09
  int 21
  mov DX, offset encabezado_carnet
  mov AH, 09
  int 21
  mov DX, offset proyecto
  mov AH, 09
  int 21

  ; mov ah, 86h        ; Función 86h de la interrupción 15h (esperar 1 segundo)
  ; mov cx, 40h          ; Esperar 1/2 segundo
  ; int 15h


		;; ingreso al modo de video 13h
		mov AL, 13
		mov AH, 00
		int 10

  menu_principal:
		call limpiar_pantalla
		mov DH, 08
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion_principal_1
		mov AH, 09
		int 21
		mov DH, 0a
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion_principal_2
		mov AH, 09
		int 21
		mov DH, 0c
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion_principal_3
		mov AH, 09
		int 21

  esperar_opcion_menu_principal:
		mov AH, 00
		int 16
		cmp AH, 3b
		je menu_inicio_de_sesion
		cmp AH, 3c
		je registro
		cmp AH, 3d
		je fin
		jmp esperar_opcion_menu_principal

  registro:
		call limpiar_pantalla
		mov DH, 08
		mov DL, 04
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset cadena_pedir_nombre
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		mov AL, TAM_NOMBRE
		mov DI, offset usuario_nombre
		call copiar_dato
		;;
		mov DH, 0a
		mov DL, 04
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset cadena_pedir_contra
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		mov AL, TAM_CONTRA
		mov DI, offset usuario_contra
		call copiar_dato
		;;
		mov AL, USUARIO_NORMAL
		mov [usuario_tipo], AL
		;;
		mov AL, NO_BLOQUEADO
		mov [usuario_bloqueado], AL
		;;
		call escribir_usuario
		call limpiar_pantalla
		jmp menu_principal


  menu_inicio_de_sesion:
    call limpiar_pantalla
		mov DH, 08
		mov DL, 04
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset cadena_pedir_nombre
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		mov AL, TAM_NOMBRE
		mov DI, offset login_usuario_nombre
		call copiar_dato
		;;
		mov DH, 0a
		mov DL, 04
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset cadena_pedir_contra
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		mov AL, TAM_CONTRA
		mov DI, offset login_usuario_contra
		call copiar_dato

    lea di, admin_nombre
    lea si, login_usuario_nombre
    call comparar_cadenas
    cmp dl, 01
    je validar_admin_contra
    ; je menu_usuario
    jmp leer_registro_usuario


  validar_admin_contra:
    lea di, admin_contra
    lea si, login_usuario_contra

    call comparar_cadenas

    cmp dl, 01
    je menu_usuario
    jmp leer_registro_usuario

  leer_registro_usuario:

    ; mov [handle_a], offset usuarios_archivo
    mov ax, 0000
    mov [indice_usuarios], ax

    call obtener_cantidad_de_registros_usuarios

    mov cx, [cantidad_de_registros_usuarios]
    ; dec cx
    ; push cx


  edit_ciclo_leer_usuarios:
    mov ax, [indice_usuarios]
    mov dx, 2fh
    mul dx

    mov dx, ax
    mov ah, 42h
    mov al, 00
    mov bx, offset usuarios_archivo
    int 21

    call leer_usuario

    lea si, usuario_nombre
    lea di, login_usuario_nombre

    call comparar_cadenas
    cmp dl, 01
    je menu_usuario

  
    mov ax, [indice_usuarios]
    cmp cx, ax
    jg incrementar_indice_usuarios

    jmp menu_principal

  incrementar_indice_usuarios:
    inc [indice_usuarios]
    jmp edit_ciclo_leer_usuarios

  ; ciclo_leer_usuarios:

  ;   mov AX, [indice_usuarios]
	; 	mov DX, 2fh
	; 	mul DX
	; 	;;
	; 	mov DX, AX
	; 	mov AH, 42
	; 	mov AL, 00
	; 	; mov BX, [handle_a]
	; 	mov BX, offset usuarios_archivo
	; 	mov CX, 00
	; 	int 21

  ;   call leer_usuario

  ;   ; mov DH, ax
	; 	; mov DL, 04
	; 	; mov BH, 00
	; 	; mov AH, 02
	; 	; int 10
	; 	; mov DX, offset usuario_nombre
	; 	; mov AH, 09
	; 	; int 21

  ;   lea si, usuario_nombre
  ;   lea di, login_usuario_nombre

  ;   call comparar_cadenas

  ;   cmp dl, 01
  ;   je menu_usuario

  ;   ; jmp menu_principal

  ; siguiente_iteracion_usuario:
  ;   inc [indice_usuarios]
  ;   pop cx
  ;   loop ciclo_leer_usuarios

  ;   jmp menu_principal
  
  comparar_cadenas:
    ; Subrutina para comparar dos cadenas
    ; Entradas: SI apunta a la primera cadena, DI apunta a la segunda cadena
    ; Salida: DL contiene 1 si son iguales, 0 si no lo son

    xor dl, dl  ; Inicializa DL en 0

  comparar_bytes:
    mov al, [si]
    cmp al, [di]
    jne cadenas_no_iguales

    ; Avanza al siguiente byte de cada cadena
    inc si
    inc di


    ; Si llegamos al final de una cadena, las cadenas son iguales
    cmp al, 00
    je cadenas_iguales

    ; Continuar comparando
    jmp comparar_bytes

  cadenas_iguales:
    mov dl, 1  ; Establece DL en 1 para indicar que las cadenas son iguales
    ret

  cadenas_no_iguales:
    ret


  leer_usuario:
		mov AH, 3fh
		mov BX, offset usuarios_archivo
		mov CX, 2fh
		mov DX, offset login_buffer
		int 21

    lea si, login_buffer
    lea di, usuario_nombre
    mov cx, 14
    rep movsb

    lea si, login_buffer + 14
    lea di, usuario_contra
    mov cx, 19
    rep movsb

    mov al, [si]
    mov usuario_tipo, al

    mov al, [si+1]
    mov usuario_bloqueado, al


		ret

  obtener_cantidad_de_registros_usuarios:
		mov AH, 42
		mov AL, 02
		; mov BX, [handle_a]
		mov BX, offset usuarios_archivo
		mov CX, 00
		mov DX, 00
		int 21
		mov DX, 00
		mov CX, 2fh
		div CX
		mov [cantidad_de_registros_usuarios], AX
		ret


  menu_usuario:
		call limpiar_pantalla
		mov DH, 08
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion1
		mov AH, 09
		int 21
		mov DH, 0a
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion2
		mov AH, 09
		int 21
		mov DH, 0c
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion3
		mov AH, 09
		int 21
		mov DH, 0e
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion4
		mov AH, 09
		int 21
		;;
  esperar_opcion_menu:
		mov AH, 00
		int 16
		cmp AH, 3b
		je jugar
		cmp AH, 3c
		je generar_puntaje
		cmp AH, 3d
		je ordenar_puntajes
		cmp AH, 3e
		je menu_principal
		jmp esperar_opcion_menu

  jugar:
		call limpiar_pantalla

    mov bh, 00
  pintar_acera_superior:
		mov al, bh
		mov AH, 01
		mov BL, ACERA
		call colocar_en_mapa
		add bh, 1
		cmp bh, 28h
		jb pintar_acera_superior
		call pintar_mapa

		mov bh, 00
  pintar_acera_inferior:
		mov al, bh
		mov AH, 17h
		mov BL, ACERA
		call colocar_en_mapa
		add bh, 1
		cmp bh, 28h
		jb pintar_acera_inferior
		call pintar_mapa

    mov cl, 02

  pintar_carriles_loop:
    xor bh, bh

  pintar_carriles:
    mov al, bh
    mov ah, cl
    mov bl, CARRIL
    call colocar_en_mapa
    add bh, 1
    cmp bh, 28h
    jb pintar_carriles
    add cl, 1
    cmp cl, 17h
    jb pintar_carriles_loop
    call pintar_mapa

  
    ; Colocar los vehiculos en la posicion correspondiente
    mov cl, 02h
    mov si, offset posiciones_vehiculos_arreglo
    xor al, al

  pintar_vehiculos_loop:
    mov al, [si]
    mov ah, cl 
    mov bl, CARRO1
	  push si
    ; mov posicion_carro, ax
    call colocar_en_mapa
    pop si
    inc si
    inc cl

    cmp cl, 17h  ; Si llega a la fila 23 (ultimo carril), que deje de imprimir vehiculos
    jb pintar_vehiculos_loop

    ; IMPRIMIR Nombre Jugador  
    ; mov DH, 00
		; mov DL, 00
		; mov BH, 00
		; mov AH, 02
		; int 10
		; mov DX, offset usuario_nombre
		; mov AH, 09
		; int 21


  pintar_jugador:
    xor bh, bh

    ; IMPRIMIR PUNTOS  
    mov AX, [juego_puntos]
		call numAstr

    mov DH, 00
		mov DL, 00
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset numero
		mov AH, 09
		int 21

  ; IMPRIMIR VIDAS
    mov DH, 00
		mov DL, 10
		mov BH, 00
		mov AH, 02
		int 10

    mov ch, vidas_restantes
    cmp ch, 03
    je imprimir_vidas_restantes_3
    cmp ch, 02
    je imprimir_vidas_restantes_2
    cmp ch, 01
    je imprimir_vidas_restantes_1
    jmp juego_perdido


  imprimir_vidas_restantes_3:
		mov DX, offset vidas3
		mov AH, 09
		int 21
    jmp ciclo_juego_imprimir
  imprimir_vidas_restantes_2:
		mov DX, offset vidas2
		mov AH, 09
		int 21
    jmp ciclo_juego_imprimir
  imprimir_vidas_restantes_1:
		mov DX, offset vidas1
		mov AH, 09
		int 21
    jmp ciclo_juego_imprimir

  ciclo_juego_imprimir:

    call pintar_mapa

    call juego_mover_jugador

    call mover_vehiculos

    call esperar_delay

    jmp pintar_jugador

  juego_mover_jugador:

    ; obtener las coordenadas del jugador
    mov ax, coordenadas_jugador

    cmp ah, 17h
    je juego_pintar_jugador_en_acera
    cmp ah, 01h
    je ha_cruzado
    jmp juego_pintar_jugador_en_carril

  juego_pintar_jugador_en_acera:    
    mov bl, JUGADOR_ACERA
    jmp juego_pintar_jugador

  juego_pintar_jugador_en_carril:
    mov bl, JUGADOR_CARRIL
    jmp juego_pintar_jugador

  juego_pintar_jugador:
    call colocar_en_mapa
    call pintar_mapa

  esperar_direccion_jugador:
    mov AH, 00
		int 16

    cmp ah, 47
    je subir_jugador
    cmp ah, 4f
    je bajar_jugador
    cmp ah, 51
    je mover_derecha_jugador
    cmp ah, 53
    je mover_izquierda_jugador
    cmp ah, 01
    je pausa
    jmp retorno

  subir_jugador:
    call limpiar_jugador
    mov ax, coordenadas_jugador
    dec ah
    mov coordenadas_jugador, ax
    ret
  
  bajar_jugador:
    call limpiar_jugador
    mov cx, coordenadas_jugador
    inc ch
    mov coordenadas_jugador, cx
    ret
  mover_derecha_jugador:
    call limpiar_jugador
    mov cx, coordenadas_jugador
    inc cl
    mov coordenadas_jugador, cx
    ret
  mover_izquierda_jugador:
    call limpiar_jugador
    mov cx, coordenadas_jugador
    dec cl
    mov coordenadas_jugador, cx
    ret

  limpiar_jugador:
    mov cx, coordenadas_jugador
    mov ax, cx
    cmp ah, 17h
    je limpiar_jugador_acera
    cmp ah, 01h
    je limpiar_jugador_acera
    jmp limpiar_jugador_carril

  limpiar_jugador_acera:
    mov bl, ACERA
    jmp limpiar_casilla

  limpiar_jugador_carril:
    mov bl, CARRIL
    jmp limpiar_casilla

  limpiar_casilla:
    call colocar_en_mapa
    ret


  mover_vehiculos:
    mov si, offset posiciones_vehiculos_arreglo
    xor cx, cx
    mov cl, 02h
    mov ch, 00

  ciclo_mover_vehiculos:
    mov al, [si]

    mov ah, cl 
    mov bl, CARRIL
    push si

    call colocar_en_mapa

    pop si
    mov al, [si]

    cmp ch, 00
    je mover_vehiculo_hacia_derecha
    jmp mover_vehiculo_hacia_izquierda

    ; cmp ch, 00
    ; je mover_vehiculo_hacia_derecha

  mover_vehiculo_hacia_derecha:
    mov ch, 01
    cmp al, 27h
    je mover_vehiculo_hasta_la_izquierda
    inc al
    mov [si], al
    jmp cambiar_casilla_vehiculo

  mover_vehiculo_hacia_izquierda:
    mov ch, 00
    cmp al, 00
    je mover_vehiculo_hasta_la_derecha
    dec al
    mov [si], al
    jmp cambiar_casilla_vehiculo

  mover_vehiculo_hasta_la_izquierda:
    mov al, 00
    mov [si], al
    jmp cambiar_casilla_vehiculo

  mover_vehiculo_hasta_la_derecha:
    mov al, 27h
    mov [si], al
    jmp cambiar_casilla_vehiculo

  cambiar_casilla_vehiculo:
    ; mov al, 01
    mov ah, cl
    mov bl, CARRO1
    push si
    call colocar_en_mapa
    pop si

    mov ah, cl
    mov al, [si]
    ; mov dl, 03
    ; mov DH, 02
    mov dx, coordenadas_jugador
    cmp ax, dx
    je colision_vehiculo_jugador


  continuar_cambiar_casilla_vehiculo:
    inc si
    inc cl

    cmp cl, 17h 
    jb ciclo_mover_vehiculos

    ; call pintar_mapa
    ret

  esperar_delay:
    mov ah, 86h        ; Función 86h de la interrupción 15h (esperar 1 segundo)
    mov cx, 2h          ; Esperar 1/2 segundo
    int 15h
    ret
    ; jmp mover_vehiculos


  colision_vehiculo_jugador:
    mov coordenadas_jugador, 1714h
    mov ch, vidas_restantes
    dec ch
    mov vidas_restantes, ch
    jmp pintar_jugador

  
  pausa:
    call limpiar_pantalla

    mov DH, 08
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset pausa_opcion_1
		mov AH, 09
		int 21
		mov DH, 0a
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset pausa_opcion_2
		mov AH, 09
		int 21

  pausa_esperar_opcion:
    mov AH, 00
		int 16
		cmp AH, 3b
		je pintar_jugador
		cmp AH, 3c
		je menu_usuario
		jmp pausa_esperar_opcion

  ha_cruzado:
    ; mover al jugador al punto de inicio
    mov coordenadas_jugador, 1714h
    ; obtener el numero de vidas restantes
    mov ch, vidas_restantes
    cmp ch, 03
    je punteo_3_vidas
    cmp ch, 02
    je punteo_2_vidas
    cmp ch, 01
    je punteo_1_vidas

  punteo_3_vidas:
    mov ax, juego_puntos
    add ax, 64h
    mov juego_puntos, ax
    jmp pintar_jugador
  punteo_2_vidas:
    mov ax, juego_puntos
    add ax, 32h
    mov juego_puntos, ax
    jmp pintar_jugador
  punteo_1_vidas:
    mov ax, juego_puntos
    add ax, 19h
    mov juego_puntos, ax
    jmp pintar_jugador


  juego_perdido:
    call limpiar_pantalla

    mov DH, 08
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset mensaje_fin_de_juego
		mov AH, 09
		int 21

    mov AX, [juego_puntos]
		call numAstr

    mov DH, 0a
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset numero
		mov AH, 09
		int 21

    mov juego_puntos, 00
    mov coordenadas_jugador, 1714h
    mov vidas_restantes, 3h

    mov ah, 86h        ; Función 86h de la interrupción 15h (esperar 1 segundo)
    mov cx, 40h          ; Esperar 5 segundos
    int 15h
    jmp generar_puntaje


  generar_puntaje:
		mov AX, 00
		mov [juego_cod_usuario], AX
		mov AH, 2c
		int 21
		mov AX, 0f0f
		and AX, DX
		mov [juego_puntos], AX
		mov AH, 2c
		int 21
		mov AX, 0a0a
		and AX, DX
		mov [juego_tiempo], AX
		;;
		mov AH, 3d
		mov AL, 02
		mov DX, offset juegos_archivo
		int 21
		jc crear_archivo_juegos
		jmp guardar_puntaje
  crear_archivo_juegos:
		mov AH, 3c
		mov CX, 00
		mov DX, offset juegos_archivo
		int 21
  guardar_puntaje:
		mov BX, AX
		mov AH, 42
		mov AL, 02
		mov CX, 00
		mov DX, 00
		int 21
		mov AH, 40
		mov CX, 0006
		mov DX, offset juego_cod_usuario
		int 21
		mov AH, 3e
		int 21
		jmp menu_usuario

  ordenar_puntajes:
		call limpiar_pantalla
		mov SI, offset juegos_archivo
		mov DI, offset copia_puntos
		call copiar_archivo
		;; abrir copia
		mov AH, 3d
		mov AL, 02
		mov DX, offset copia_puntos
		int 21
		mov [handle_a], AX
		call burbuja_archivo
		;; abrir copia de nuevo, 'burbuja_archivo' lo cierra para que se ejecuten los cambios
		mov AH, 3d
		mov AL, 02
		mov DX, offset copia_puntos
		int 21
		mov [handle_a], AX
		call imprimir_juegos_copia
		call limpiar_pantalla
		jmp menu_usuario

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
    cmp BL, JUGADOR_ACERA
    je pintar_jugador_acera
    cmp BL, CARRO1
    je pintar_vehiculo
    cmp BL, CAMIONI
    je pintar_camion_i
    cmp BL, CAMIOND
    je pintar_camion_d
  	jmp ciclo_columnas_mapa_loop

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

  pintar_acera:
		mov BX, offset sprite_banqueta
		jmp pintar_sprite_en_posicion
  pintar_carril:
		mov BX, offset sprite_carril
		jmp pintar_sprite_en_posicion
  pintar_jugador_carril:
		mov BX, offset sprite_jugador_carril
		jmp pintar_sprite_en_posicion
  pintar_jugador_acera:
		mov BX, offset sprite_jugador_acera
		jmp pintar_sprite_en_posicion
  pintar_vehiculo:
    mov BX, offset sprite_carro
    jmp pintar_sprite_en_posicion
  pintar_camion_i:
    mov BX, offset sprite_camion_izquierdo
    jmp pintar_sprite_en_posicion
  pintar_camion_d:
    mov BX, offset sprite_camion_derecho
    jmp pintar_sprite_en_posicion
  


;; escribir_usuario - escribe un usuario en el archivo USRS.ACE
;; ENTRADA:
;;   - [usuario_nombre] -> nombre del usuario
;;   - ...
  escribir_usuario:
		mov AH, 3d
		mov AL, 02
		mov DX, offset usuarios_archivo
		int 21
		jc crear_archivo
		jmp escribir_estructura_usuario
  crear_archivo:
		mov AH, 3c
		mov CX, 0000
		mov DX, offset usuarios_archivo
		int 21
  escribir_estructura_usuario:
		;; posicionar en el final del archivo
		mov BX, AX   ; handle
		mov AL, 02
		mov CX, 0000
		mov DX, 0000
		mov AH, 42
		int 21
		;; guardar el usuario
		mov AH, 40
		mov CX, 002f
		mov DX, offset usuario_nombre
		int 21
		;; cerrar archivo
		mov AH, 3e
		int 21
		ret

;; copiar_dato - copia el contenido del buffer en el campo indicado
;; ENTRADA:
;;   - AL -> tamaño del campo
;;   - DI -> direccion del campo
  copiar_dato:
		mov CX, 0000
		mov CL, AL
		mov AH, 00
		push DI
  ciclo_limpiar_dato:
		mov [DI], AH
		inc DI
		loop ciclo_limpiar_dato
		pop DI
		;;
		mov SI, offset buffer_entrada
		inc SI
		mov AL, [SI]
		mov CX, 0000
		mov CL, AL
		inc SI
  ciclo_copiar_dato:
		mov AL, [SI]
		mov [DI], AL
		inc DI
		inc SI
		loop ciclo_copiar_dato
		ret

;; limpiar_pantalla - limpia la pantalla
  limpiar_pantalla:
		push CX
		mov CX, 1a
  ciclo_limpiar_pantalla:
		mov DX, offset cadena_limpiar
		mov AH, 09
		int 21
		loop ciclo_limpiar_pantalla
		pop CX
		ret

;; copiar_archivo - copia un archivo
;; ENTRADA:
;;   SI -> nombre del archivo origen
;;   DI -> nombre del archivo destino
;; SALIDA:
  copiar_archivo:
		;; abrir archivo origen
		mov AH, 3d
		mov AL, 00
		mov DX, SI
		int 21
		;
		mov BX, AX
		mov [handle_a], BX
		;; obtener tamaño de archivo origen
		mov AH, 42
		mov AL, 02
		mov CX, 00
		mov DX, 00
		int 21
		;; AX -> tamaño del archivo en bytes
		mov [tam_archivo_origen], AX
		;; reestablecer puntero de archivo
		mov AH, 42
		mov AL, 00
		mov CX, 00
		mov DX, 00
		int 21
		;; abrir o crear archivo destino
		mov AH, 3d
		mov AL, 01
		mov DX, DI
		int 21
		jc crear_archivo_para_copiar
		jmp guardar_handle_b
  crear_archivo_para_copiar:
		mov AH, 3c
		mov CX, 0000
		mov DX, DI
		int 21
		;
  guardar_handle_b:
		mov [handle_b], AX
		;; truncar archivo destino
		mov AH, 40
		mov BX, [handle_b]
		mov CX, 00
		mov DX, offset un_byte
		int 21
		;; inicializar contador
		mov CX, [tam_archivo_origen]
  ciclo_copiar_archivo:
		push CX
		;; leer un byte
		mov AH, 3f
		mov BX, [handle_a]
		mov CX, 0001
		mov DX, offset un_byte
		int 21
		;; copiar un byte
		mov AH, 40
		mov BX, [handle_b]
		mov CX, 0001
		mov DX, offset un_byte
		int 21
		;;
		pop CX
		loop ciclo_copiar_archivo
		;; cerrar archivos
		mov AH, 3e
		mov BX, [handle_a]
		int 21
		mov AH, 3e
		mov BX, [handle_b]
		int 21
		ret

;; obtener_cantidad_de_registros
  obtener_cantidad_de_registros:
		mov AH, 42
		mov AL, 02
		mov BX, [handle_a]
		mov CX, 00
		mov DX, 00
		int 21
		mov DX, 00
		mov CX, 0006
		div CX
		mov [cantidad_de_registros], AX
		ret

;; inicializar puntero de archivo
  inicializar_puntero_de_archivo:
		mov AH, 42
		mov AL, 00
		mov BX, [handle_a]
		mov CX, 00
		mov DX, 00
		int 21
		ret

  leer_juego:
		mov AH, 3f
		mov BX, [handle_a]
		mov CX, 0006
		mov DX, offset juego_cod_usuario
		int 21
		ret

  verificar_intercambio:
		call leer_juego
		mov AX, [juego_puntos]
		mov [numero_a], AX
		call leer_juego
		mov AX, [juego_puntos]
		mov [numero_b], AX
		mov AX, [numero_a]
		cmp AX, [numero_b]
		jbe retornar_no_intercambio
		;;
		mov AL, 01
		mov [hubo_intercambio], AL
		ret
  retornar_no_intercambio:
		mov AL, 00
		ret

;; burbuja_archivo - ejecuta el algoritmo burbuja en un archivo abierto
;; ENTRADA:
;;   - [handle_a] -> handle del archivo a ordenar
  burbuja_archivo:
		mov AX, 0000
		mov [indice_burbuja], AX
		mov [hubo_intercambio], AL
		;;
		call obtener_cantidad_de_registros
		;;
  repetir_burbuja:
		call inicializar_puntero_de_archivo
		mov CX, [cantidad_de_registros]
		mov AL, 00
		mov [hubo_intercambio], AL
		mov AX, 0000
		mov [indice_burbuja], AX
  ciclo_burbuja_archivo:
		push CX
		;; posicionarse en el registro actual dentro del archivo
		mov AX, [indice_burbuja]
		mov DX, 0006
		mul DX
		;;
		mov DX, AX
		mov AH, 42
		mov AL, 00
		mov BX, [handle_a]
		mov CX, 00
		int 21
		;;
		call verificar_intercambio
		cmp AL, 01
		je intercambiar
		jmp siguiente_iteracion
		;;
  intercambiar:
		mov AX, [indice_burbuja]
		mov DX, 0006
		mul DX
		;; AX -> posición del registro actual en el archivo
		mov DX, AX
		mov AH, 42
		mov AL, 00
		mov BX, [handle_a]
		mov CX, 00
		int 21
		;;
		call leer_juego
		mov AX, [juego_cod_usuario]
		mov [juego_tmp_cod_usuario], AX
		mov AX, [juego_puntos]
		mov [juego_tmp_puntos], AX
		mov AX, [juego_tiempo]
		mov [juego_tmp_tiempo], AX
		call leer_juego
		;;
		mov AH, 42
		mov AL, 01
		mov BX, [handle_a]
		mov CX, 00
		mov DX, 00
		int 21
		;; DX-AX -> posición actual
		mov CX, 000c
		sub AX, CX
		;;
		mov DX, AX
		mov AH, 42
		mov AL, 00
		mov BX, [handle_a]
		mov CX, 00
		int 21
		;; escribimos el registro siguiente en la posición actual
		mov AH, 40
		mov BX, [handle_a]
		mov CX, 0006
		mov DX, offset juego_cod_usuario
		int 21
		;; escribimos el registro actual en la posición siguiente
		mov AH, 40
		mov BX, [handle_a]
		mov CX, 0006
		mov DX, offset juego_tmp_cod_usuario
		int 21
		;;
  siguiente_iteracion:
		inc [indice_burbuja]
		pop CX
		loop hacer_ciclo_burbuja
		jmp no_hacer_ciclo_burbuja
  hacer_ciclo_burbuja:
		jmp ciclo_burbuja_archivo
  no_hacer_ciclo_burbuja:
		;; verificar si se debe iterar de nuevo
		mov AL, [hubo_intercambio]
		cmp AL, 01
		je repetir_burbuja
		;; cerrar archivo
		mov AH, 3e
		mov BX, [handle_a]
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

;; imprimir_juegos_copia - imprime algunos registro de un archivo de juegos
  imprimir_juegos_copia:
		mov AL, 00
		mov [fila_texto], AL
		call limpiar_pantalla
		call obtener_cantidad_de_registros
		;;
		mov AH, 42
		mov AL, 00
		mov BX, [handle_a]
		mov CX, 00
		mov DX, 00
		int 21
		;;
		mov CX, [cantidad_de_registros]
		mov BP, 0005
  ciclo_imprimir_juegos_copia:
		push CX
		call leer_juego
		;; codigo
		inc [fila_texto]
		mov DH, [fila_texto]
		mov DL, 02
		mov BH, 00
		mov AH, 02
		int 10
		mov AH, 09
		mov DX, offset cadena_mostrar_cod_usuario
		int 21
		int 03
		mov AX, [juego_cod_usuario]
		call numAstr
		mov AH, 09
		mov DX, offset numero
		int 21
		;; puntos
		inc [fila_texto]
		mov DH, [fila_texto]
		mov DL, 02
		mov BH, 00
		mov AH, 02
		int 10
		mov AH, 09
		mov DX, offset cadena_mostrar_cod_puntos
		int 21
		mov AX, [juego_puntos]
		call numAstr
		mov AH, 09
		mov DX, offset numero
		int 21
		;; tiempo
		inc [fila_texto]
		mov DH, [fila_texto]
		mov DL, 02
		mov BH, 00
		mov AH, 02
		int 10
		mov AH, 09
		mov DX, offset cadena_mostrar_cod_tiempo
		int 21
		mov AX, [juego_tiempo]
		call numAstr
		mov AH, 09
		mov DX, offset numero
		int 21
		;; separador
		inc [fila_texto]
		mov DH, [fila_texto]
		mov DL, 02
		mov BH, 00
		mov AH, 02
		int 10
		mov AH, 09
		mov DX, offset cadena_separador
		int 21
		;;
		;;
		dec BP
		cmp BP, 0000
		jne hacer_ciclo_imprimir_juegos_copia
		;; ayuda
		inc [fila_texto]
		inc [fila_texto]
		mov DH, [fila_texto]
		mov DL, 02
		mov BH, 00
		mov AH, 02
		int 10
		mov AH, 09
		mov DX, offset cadena_ayuda
		int 21
		;;;
		mov AH, 08
		int 21
		;;
		call limpiar_pantalla
		mov AL, 00
		mov [fila_texto], AL
		mov BP, 0005
  hacer_ciclo_imprimir_juegos_copia:
		pop CX
		loop otra_iteracion_imprimir
		jmp retorno_imprimir
  otra_iteracion_imprimir:
		jmp ciclo_imprimir_juegos_copia
  retorno_imprimir:
		;; cerrar archivo
		mov AH, 3e
		mov BX, [handle_a]
		int 21
		;;
		inc [fila_texto]
		mov DH, [fila_texto]
		mov DL, 02
		mov BH, 00
		mov AH, 02
		int 10
		mov AH, 09
		mov DX, offset cadena_ayuda_fin
		int 21
		;;;
		mov AH, 08
		int 21
		;;
		ret


fin:
.EXIT
END
