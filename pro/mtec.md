# Manual Tecnico
---
# Índice
1. [Requerimientos](#requerimientos)
3. [Configuración](#configuración)
3. [Ensamblador](#ensamblador)



## Requerimientos
 - DOSBox 0.74 32 Bits
 - MASM v6.11
 - Visual Studio Code


## Configuración
Para configurar el programa para que funcione bien se debe copiar el siguiente pedazo de codigo en el archivo DOS Options.conf y guardarlo. El archivo Options.conf se puede encontrar si se busca directamente en el buscador que tiene integrado la barra de tareas de windows.
```
mount c "C:\Users\Jorge\OneDrive\Documents\USAC DOCUMENTS\segundo semestre 2023\arqui1\practica3"
c:
set PATH=Z:\;C:\MASM611\BIN;C:\MASM611\BINR;C:\DEBUG\BIN
cd pro
ml uni.asm
```

Para compilar el archivo .asm se debe de ejecutar el siguiente comando

```
ml uni.as
```

Para ejecutar el archivo solamente se debe ejecutar el .exe de la siguiente manera

```
uni.exe
```

## Ensamblador 
Todo el codigo en el archivo .asm maneja numeros en base hexadecimal ya que tiene en su primera linea la siguiente etiqueta:
```
.MODEL small
.RADIX 16
.STACK
``` 


Luego se encuentran todas las variables utilizadas a lo largo del codigo para almacenar en memoria.
```
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

;; ESTRUCTURA USUARIO -> 2f bytes
usuario_nombre    db 14 dup (00)
usuario_contra    db 19 dup (00)
usuario_tipo      db         00
usuario_bloqueado db         00

;; VARIABLES PARA INICIO DE SESION
login_usuario_nombre db 14 dup (00)
login_usuario_contra db 19 dup (00)

login_buffer db 2Fh dup (00)  ; Bufer para almacenar una estructura de usuario


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
```