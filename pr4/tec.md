# Manual Técnico - Práctica 4

## Introducción
Este manual técnico proporciona información detallada sobre el programa en ensamblador que opera en un entorno DOS utilizando el ensamblador MASM y utiliza una representación en base 16 (radix 16). El programa ofrece opciones para cargar archivos, entrar en el modo calculadora, calcular factoriales, generar un informe y salir. Para ejecutar el programa, se requiere el uso de DOSBox y los comandos "ml pr4.asm" y "pr4.exe".

## Requisitos del Sistema
- DOSBox instalado en su sistema.
- Conocimientos de ensamblador y programación en DOS.
- Archivo fuente "pr4.asm" y archivo ejecutable "pr4.exe".

## Compilación y Ejecución
1. Abra DOSBox en su sistema.
2. Monte el directorio que contiene el programa en ensamblador y los archivos necesarios.

```
mount c c:\ruta\al\programa
```

1. Cambie al directorio de trabajo donde se encuentra el archivo "pr4.asm".

```
c:
cd \ruta\al\programa
```
Compile el archivo "pr4.asm" utilizando el ensamblador MASM.
```
ml pr4.asm
```

Ejecute el programa resultante "pr4.exe".
```
pr4.exe
```

## Estructura del Programa
El programa está diseñado para ser interactivo y utiliza una estructura de menú para que el usuario pueda seleccionar las siguientes opciones:

Cargar Archivo: Permite al usuario cargar un archivo con operaciones en notación preorden.

Modo Calculadora: Ingresa en el modo calculadora, donde el usuario puede realizar operaciones aritméticas introduciendo números y operadores (+, -, *, /) en formato radix 16. El resultado se muestra en el mismo formato.

Factorial: Calcula el factorial de un número ingresado en formato radix 16.

Reporte: Muestra un informe con todas las operaciones realizadas por el usuario.

Salir: Termina la ejecución del programa.

## Uso del Programa
Siga las instrucciones proporcionadas en el menú para seleccionar una opción.
Cuando se le solicite ingresar números o expresiones, hágalo en formato radix 16. Por ejemplo, "A + 3" en lugar de "10 + 3".
Para cargar un archivo, asegúrese de que el archivo tenga la extensión ".arq" y contenga operaciones en notación preorden.
## Notas Finales
Este programa se desarrolló utilizando ensamblador y está diseñado para operar en un entorno DOS.
La representación en base 16 (radix 16) se utiliza para todas las operaciones en el programa.
El usuario debe seguir las instrucciones proporcionadas en el menú para utilizar el programa de manera efectiva.
Si se encuentran problemas o errores durante la ejecución, es recomendable verificar la sintaxis y el formato de las operaciones ingresadas.
¡Gracias por utilizar nuestro programa en ensamblador con DOS y MASM en radix 16! Si tiene preguntas o necesita asistencia adicional, no dude en ponerse en contacto con nuestro equipo de soporte técnico.