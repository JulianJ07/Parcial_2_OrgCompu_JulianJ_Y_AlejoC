# Parcial_2_OrgCompu_JulianJ_Y_AlejoC

**Elaborado por:** Julian Jiménez y Alejandro Cifuentes

## Introducción

El presente informe describe el desarrollo de las partes 2 y 3 del trabajo práctico en lenguaje ensamblador para la plataforma Hack. La Parte 2 se enfoca en el cálculo algorítmico de la parte entera de la raíz cuadrada de un número entero positivo, mientras que la Parte 3 aborda la interacción con el teclado y la representación gráfica de caracteres en pantalla. En ambos casos se empleó exclusivamente el conjunto de instrucciones de la arquitectura Hack, respetando las restricciones establecidas en el enunciado. La solución implementada prioriza la claridad del algoritmo, la organización del código y el cumplimiento de la funcionalidad solicitada.

## Objetivos

### Objetivo general

Desarrollar soluciones en lenguaje ensamblador para la plataforma Hack que permitan resolver un problema de cálculo algorítmico y un problema de interacción gráfica, aplicando correctamente el modelo de memoria y las instrucciones propias de la arquitectura.

### Objetivos específicos

- Implementar un programa que calcule la parte entera de la raíz cuadrada de un número almacenado en `R1`, dejando el resultado en `R3`.
- Diseñar un programa que lea el teclado y dibuje letras específicas en la pantalla de la computadora Hack.
- Emplear correctamente la memoria de pantalla y el registro de teclado para controlar la salida visual y la entrada del usuario.
- Documentar el diseño utilizado para la representación gráfica de las letras mediante un esquema de mapa de bits.

---

# Parte 2: Cálculo Algorítmico en ASM

## Descripción del problema

En esta parte se desarrolló un programa en ensamblador Hack cuyo objetivo es calcular la parte entera de la raíz cuadrada de un número entero `n`. El valor de entrada se encuentra precargado en el registro `R1` y el resultado final debe almacenarse en `R3`. La solución implementada se basa en el método de resta sucesiva de números impares, el cual permite obtener la raíz cuadrada entera sin recurrir a operaciones complejas no disponibles en la plataforma Hack.

## Fundamento del algoritmo

El método de resta sucesiva de números impares se basa en una propiedad matemática según la cual la suma de los primeros números impares genera cuadrados perfectos:

- `1 = 1²`
- `1 + 3 = 4 = 2²`
- `1 + 3 + 5 = 9 = 3²`
- `1 + 3 + 5 + 7 = 16 = 4²`

A partir de esta propiedad, el algoritmo consiste en restar del número de entrada la secuencia de números impares `1, 3, 5, 7, ...` hasta que ya no sea posible continuar sin que el valor restante se vuelva negativo. La cantidad de restas exitosas realizadas corresponde a la parte entera de la raíz cuadrada del número original.

## Lógica implementada

El programa comienza copiando el contenido de `R1` al registro `R2`, el cual se utiliza como valor restante de trabajo. Posteriormente, inicializa `R3` en cero para representar el resultado acumulado y establece en `R4` el valor `1`, correspondiente al primer número impar de la secuencia.

Luego entra en un ciclo que compara el valor restante con el impar actual. Si el restante es menor que el impar, el programa finaliza; de lo contrario, resta dicho impar al restante, incrementa el resultado en uno y aumenta el impar en dos unidades para pasar al siguiente número impar. Finalmente, cuando la condición de parada se cumple, el programa se detiene dejando en `R3` la raíz cuadrada entera calculada.

## Registros utilizados

- `R1`: contiene el número de entrada `n`.
- `R2`: almacena una copia del valor de entrada y se usa como valor restante durante el proceso.
- `R3`: guarda el resultado final, es decir, la parte entera de la raíz cuadrada.
- `R4`: contiene el número impar actual que se resta en cada iteración.

## Funcionamiento paso a paso

1. Se copia el valor de `R1` en `R2`.
2. Se inicializa `R3` en `0`.
3. Se inicializa `R4` en `1`.
4. Se compara si el valor restante (`R2`) es menor que el impar actual (`R4`).
5. Si `R2` es menor que `R4`, el programa termina.
6. Si `R2` es mayor o igual que `R4`, entonces:
   - se actualiza `R2 = R2 - R4`,
   - se incrementa `R3` en `1`,
   - se incrementa `R4` en `2`.
7. El ciclo se repite hasta que ya no sea posible seguir restando.

## Ejemplo conceptual

Si el valor de entrada es `9`, el proceso sería el siguiente:

- `9 - 1 = 8`
- `8 - 3 = 5`
- `5 - 5 = 0`

Se realizaron tres restas exitosas, por lo tanto el valor final almacenado en `R3` es `3`, que corresponde a `floor(sqrt(9))`.

Si el valor de entrada es `15`, el proceso sería:

- `15 - 1 = 14`
- `14 - 3 = 11`
- `11 - 5 = 6`
- `6 - 7` ya no es posible sin volver el valor negativo

En este caso se realizaron tres restas exitosas, por lo que `R3 = 3`, que corresponde a `floor(sqrt(15))`.

## Análisis de la solución

La solución propuesta para la Parte 2 es adecuada para la arquitectura Hack porque evita operaciones no disponibles, como multiplicación, división o cálculo de raíces de manera directa. El algoritmo es sencillo, claro y apropiado para el contexto académico del ejercicio. Además, la estructura del código se encuentra organizada en una fase de inicialización, un ciclo principal de cálculo y una fase final de detención del programa.

---

# Parte 3: Interacción y Gráficos

## Nota:
Para visualizar más rapido la construccion de las letras, poner en "animate" a "no animate"

## Descripción del problema

En esta parte se implementó un programa que interactúa con el teclado de la computadora Hack y genera una salida visual en pantalla. La funcionalidad definida consiste en detectar la pulsación de determinadas teclas asociadas a letras seleccionadas por los integrantes del equipo. En la solución desarrollada se eligieron las letras **A** y **J**, de manera que al presionar alguna de estas teclas se dibuja la letra correspondiente en la pantalla. Si se presiona cualquier otra tecla, el contenido visual no debe sufrir modificaciones.

## Lógica general del programa

El programa se organiza alrededor de un ciclo principal denominado `MAIN`. En este ciclo se consulta de forma constante el contenido del registro `KBD`, que en la arquitectura Hack almacena el código ASCII de la tecla presionada. El programa compara ese valor con `65` para la letra `A` y con `74` para la letra `J`. Si la comparación resulta verdadera, se transfiere el control a la rutina de dibujo correspondiente, ya sea `DRAW_A` o `DRAW_J`. Si ninguna comparación coincide, el flujo regresa al inicio del ciclo principal y continúa esperando una entrada válida.

Después de dibujar una letra, el programa no vuelve inmediatamente al ciclo principal, sino que pasa por una rutina denominada `WAIT_RELEASE`. Esta rutina verifica que el usuario haya soltado la tecla antes de continuar, evitando así repeticiones innecesarias del mismo dibujo mientras la tecla permanece presionada.

## Dimensiones generales y mapeo en memoria

Para la representación gráfica de las letras se utilizó una cuadrícula base de **64 píxeles de ancho por 60 píxeles de alto**. Este diseño se eligió porque en la memoria de pantalla Hack cada palabra representa 16 píxeles horizontales; por tanto, para cubrir 64 píxeles se requieren **4 palabras contiguas por fila**. La altura de 60 filas permite construir letras suficientemente grandes, visibles y proporcionadas dentro de la pantalla.

La zona de dibujo parte de la dirección base `17032`, que corresponde a una posición desplazada dentro de la memoria de pantalla. Esta base fue seleccionada para que las letras aparezcan en una región visible y estable. Antes de dibujar una letra, el programa limpia un área rectangular de **60 filas por 4 palabras de memoria por fila**, escribiendo ceros en cada posición para evitar que permanezcan trazos del dibujo anterior.

En este contexto, el valor `-1` en una palabra de memoria equivale a `1111111111111111` en binario, lo que representa 16 píxeles encendidos. Por su parte, el valor `0` equivale a `0000000000000000`, lo que representa 16 píxeles apagados. A partir de estas combinaciones se construye visualmente cada letra.

## Diseño de la letra A

La letra **A** fue construida a partir de cuatro secciones verticales que, en conjunto, ocupan las 60 filas definidas para el área de dibujo:

- **Barra superior:** 6 filas con el patrón `[-1, -1, -1, -1]`.
- **Lados verticales superiores:** 18 filas con el patrón `[-1, 0, 0, -1]`.
- **Barra media:** 6 filas con el patrón `[-1, -1, -1, -1]`.
- **Lados verticales inferiores:** 30 filas con el patrón `[-1, 0, 0, -1]`.

Este diseño permite representar una letra A mayúscula con una barra superior marcada, una barra media central y dos patas verticales laterales.

## Mapa de bits utilizado para las letras

Para representar las letras en pantalla, se utilizó un mapa de bits de gran tamaño, organizado en bloques repetidos. Cada fila de la figura ocupa varias palabras de memoria de video, con el objetivo de lograr caracteres de mayor ancho y altura. A continuación se presenta el mapa completo utilizado para cada letra.

---

### Letra A

La letra **A** fue construida a partir de **60 filas**, distribuidas en cuatro bloques:

#### 1. Barra superior  
Corresponde a las filas **1 a 6**.

```text
Fila  1: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  2: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  3: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  4: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  5: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  6: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
```

#### 2. Lados verticales  
Corresponde a las filas **7 a 24**.

```text
Fila  7: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila  8: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila  9: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 10: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 11: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 12: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 13: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 14: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 15: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 16: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 17: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 18: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 19: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 20: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 21: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 22: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 23: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 24: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
```

#### 3. Barra media  
Corresponde a las filas **25 a 30**.

```text
Fila 25: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 26: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 27: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 28: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 29: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 30: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
```

#### 4. Lados verticales inferiores  
Corresponde a las filas **31 a 60**.

```text
Fila 31: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 32: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 33: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 34: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 35: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 36: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 37: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 38: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 39: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 40: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 41: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 42: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 43: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 44: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 45: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 46: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 47: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 48: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 49: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 50: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 51: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 52: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 53: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 54: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 55: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 56: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 57: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 58: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 59: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 60: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
```

---

### Letra J

La letra **J** fue construida a partir de **60 filas**, distribuidas en cuatro bloques:

#### 1. Barra superior  
Corresponde a las filas **1 a 6**.

```text
Fila  1: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  2: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  3: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  4: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  5: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila  6: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
```

#### 2. Palo derecho  
Corresponde a las filas **7 a 30**.

```text
Fila  7: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila  8: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila  9: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 10: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 11: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 12: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 13: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 14: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 15: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 16: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 17: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 18: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 19: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 20: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 21: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 22: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 23: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 24: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 25: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 26: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 27: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 28: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 29: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
Fila 30: 0000000000000000 0000000000000000 0000000000000000 1111111111111111
```

#### 3. Gancho  
Corresponde a las filas **31 a 48**.

```text
Fila 31: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 32: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 33: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 34: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 35: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 36: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 37: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 38: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 39: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 40: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 41: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 42: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 43: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 44: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 45: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 46: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 47: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
Fila 48: 1111111111111111 0000000000000000 0000000000000000 1111111111111111
```

#### 4. Base inferior  
Corresponde a las filas **49 a 60**.

```text
Fila 49: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 50: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 51: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 52: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 53: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 54: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 55: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 56: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 57: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 58: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 59: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
Fila 60: 1111111111111111 1111111111111111 1111111111111111 1111111111111111
```

---

### Descripción general

El mapa de bits utilizado para las letras se diseñó mediante patrones binarios repetidos por bloques, con el fin de obtener caracteres grandes, claros y estables en la pantalla del emulador Hack. La letra **A** está compuesta por una barra superior, una barra media y dos columnas laterales. La letra **J** está formada por una barra superior, un trazo vertical derecho, un gancho lateral y una base inferior completa que asegura la continuidad visual de la figura.
