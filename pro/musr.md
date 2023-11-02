# Manual de Usuario
## Índice
----
1. [Introducción](#introducción)
2. [Usuarios](#usuarios)
3. [Juego](#juego)
4. [Menu Dentro de la Simulación](#menu-dentro-de-la-simulación)



## Introducción 
Para el presente programa se desarrolló un juego sencillo empleando las características gráficas que brinda DOS y el conjunto de interrupciones que este provee. Junto a este juego, se desarrolló la interfaz que permite manejarlo y acceder a las funcionalidades que se describirán más adelante. También se manejó un sistema de usuarios para facilitar la administración y el acceso al juego, y los datos que éste genere.
El juego consiste en una gran autopista por la que el jugador deberá hacer cruzar al personaje. En esta autopista estarán recorriendo vehículos de diversos tipos, éstos serán los obstáculos que deberán ser evitados por el jugador. El jugador ganará puntos por cruzar al otro lado de la autopista. El juego continuará hasta que el jugador se quede sin vidas. También se contabilizará el tiempo del jugador en cada partida, dato que también será asociado a la puntuación obtenida por el jugador.


## Usuarios
Dentro del programa se manejarán usuarios, éstos se agregarán mediante un menú de registro que permita ingresar un nombre y una contraseña. Los usuarios registrados se deberán guardar en un archivo llamado ’USRS.ACE’. El formato o estructuración del mismo queda a discreción del desarrollador.
Dentro del programa se considerarán usuarios con distintos roles. Dependiendo del rol, el usuario, tendrá acceso a una gama distinta de opciones. Existirán, usuarios normales y usuarios adminstradores.

#### Usuarios Nomrales
Los usuarios normales podrán acceder a un menú en el cuál podrán iniciar nuevas partidas, visualizar un resumen de sus últimas partidas y cerrar sesión.
#### Usuarios Administradores
Éstos usuarios, tendrán la capacidad de visualizar datos y estadísticas de todos los demás jugadores. Así como también, acceso a la funcionalidad de ordenamientos que se describirá más adelante. Además, este tipo de usuarios también incluyen las opciones que tenía originalmente cuando era usuario normal.

#### Usuario administrador original 
En este caso, el usuario administrador original tendrá todas las opciones consideradas para los roles mencionados antes. Añadiéndole de manera específica la opción para promover, o degradar, usuarios normales y convertirlos en administradores. Las credenciales para este usuario deberán ser:
– Nombre: "jperez"
– Contraseña:  "201900810A*"

#### Inicio de sesión
En el inicio de sesión, se le solicitará al usuario el nombre y la contraseña para ingresar. El usuario tendrá 3 intentos para poder escribir correctamente sus datos, de lo contrario el sistema deberá bloquearse por 10 segundos y, además, bloquear el acceso por completo a ese usuario. Acción que únicamente podrá ser revertida por un usuario administrador. Cuando se intente iniciar sesión nuevamente con un usuario bloqueado, se deberá mostrar un mensaje diferente. Mostrando que se impide el acceso por motivo de que el usuario fue bloqueado. En el caso en que se consiga escribir correctamente los datos de ingreso en los intentos permitidos, se dará acceso al sistema y se deberá registrar la fecha y hora del inicio de sesión.


## Juego
El objetivo principal del juego es que se consiga llevar al personaje del juego, hacia el otro lado de una gran autopista. Y para ello deben evitarse los vehículos que transiten en esa autopista. La autopista tendrá 21 carriles y dos aceras. Tanto los carriles como las aceras deberán ser de una altura de 8 pixeles. Como se mencionó con anterioridad, la primera y última fila de la pantalla deberá contener cierta información. Para conseguir esta configuración se recomienda tratar la pantalla como una matriz de 40x25 y en cada casilla de esa matriz colocar elementos gráficos, sprites o caracteres, de 8x8 pixeles. El jugador podrá moverse en cuatro direcciónes; arriba, abajo, izquierda y derecha; con las teclas que se especifican. Antes de iniciar la partida, se deberán definir, de manera aleatoria, tres aspectos para cada carril.
- El tipo de vehículo que recorrerá ese carril.
- El nivel de velocidad del vehículo
- La orientación del carril, ya sea que los vehículos de ese carril avancen de izquierda a derecha, o viceversa.
Al momento de que el jugador impacte con algún vehículo, se le deberá restar una vida y se le retornará a la acera inferior para que comience de nuevo el recorrido.
