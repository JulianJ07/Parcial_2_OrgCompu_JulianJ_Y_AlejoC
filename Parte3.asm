// =====================================================
// PARTE 3 - Interacción y Gráficos
// Letras: A y J
// A = ASCII 65
// J = ASCII 74
// =====================================================

(MAIN)
    @KBD
    D=M
    @65
    D=D-A
    @DRAW_A
    D;JEQ

    @KBD
    D=M
    @74
    D=D-A
    @DRAW_J
    D;JEQ

    @MAIN
    0;JMP


// =====================================================
// DIBUJAR A 
// =====================================================
(DRAW_A)
    // base = SCREEN + 20 filas + 8 columnas
    @17032
    D=A
    @R13
    M=D

    // limpiar 60 filas x 4 palabras
    @R13
    D=M
    @R14
    M=D
    @60
    D=A
    @R15
    M=D

(CLEAR_A_LOOP)
    @R14
    A=M
    M=0
    A=A+1
    M=0
    A=A+1
    M=0
    A=A+1
    M=0

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @CLEAR_A_LOOP
    D;JGT

    // volver al inicio
    @R13
    D=M
    @R14
    M=D

    // ---------------------------------
    // 6 filas: barra superior
    // patrón: 1111
    // ---------------------------------
    @6
    D=A
    @R15
    M=D

(A_TOP_LOOP)
    @R14
    A=M
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @A_TOP_LOOP
    D;JGT

    // ---------------------------------
    // 18 filas: lados verticales
    // patrón: 1001
    // ---------------------------------
    @18
    D=A
    @R15
    M=D

(A_SIDE1_LOOP)
    @R14
    A=M
    M=-1
    A=A+1
    M=0
    A=A+1
    M=0
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @A_SIDE1_LOOP
    D;JGT

    // ---------------------------------
    // 6 filas: barra media
    // patrón: 1111
    // ---------------------------------
    @6
    D=A
    @R15
    M=D

(A_MID_LOOP)
    @R14
    A=M
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @A_MID_LOOP
    D;JGT

    // ---------------------------------
    // 30 filas: lados verticales abajo
    // patrón: 1001
    // ---------------------------------
    @30
    D=A
    @R15
    M=D

(A_SIDE2_LOOP)
    @R14
    A=M
    M=-1
    A=A+1
    M=0
    A=A+1
    M=0
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @A_SIDE2_LOOP
    D;JGT

    @WAIT_RELEASE
    0;JMP


// =====================================================
// DIBUJAR J 
// =====================================================
(DRAW_J)
    // misma base
    @17032
    D=A
    @R13
    M=D

    // limpiar 60 filas x 4 palabras
    @R13
    D=M
    @R14
    M=D
    @60
    D=A
    @R15
    M=D

(CLEAR_J_LOOP)
    @R14
    A=M
    M=0
    A=A+1
    M=0
    A=A+1
    M=0
    A=A+1
    M=0

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @CLEAR_J_LOOP
    D;JGT

    // volver al inicio
    @R13
    D=M
    @R14
    M=D

    // ---------------------------------
    // 6 filas: barra superior
    // patrón: 1111
    // ---------------------------------
    @6
    D=A
    @R15
    M=D

(J_TOP_LOOP)
    @R14
    A=M
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @J_TOP_LOOP
    D;JGT

    // ---------------------------------
    // 24 filas: palo derecho
    // patrón: 0001
    // ---------------------------------
    @24
    D=A
    @R15
    M=D

(J_STEM_LOOP)
    @R14
    A=M
    M=0
    A=A+1
    M=0
    A=A+1
    M=0
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @J_STEM_LOOP
    D;JGT

    // ---------------------------------
    // 18 filas: gancho
    // patrón: 1001
    // ---------------------------------
    @18
    D=A
    @R15
    M=D

(J_HOOK_LOOP)
    @R14
    A=M
    M=-1
    A=A+1
    M=0
    A=A+1
    M=0
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @J_HOOK_LOOP
    D;JGT

    // ---------------------------------
    // 12 filas: base inferior 
    // patrón: 1111
    // ---------------------------------
    @12
    D=A
    @R15
    M=D

(J_BOTTOM_LOOP)
    @R14
    A=M
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1
    A=A+1
    M=-1

    @32
    D=A
    @R14
    M=D+M

    @R15
    MD=M-1
    @J_BOTTOM_LOOP
    D;JGT

    @WAIT_RELEASE
    0;JMP


// =====================================================
// ESPERAR A SOLTAR LA TECLA
// =====================================================
(WAIT_RELEASE)
    @KBD
    D=M
    @WAIT_RELEASE
    D;JNE

    @MAIN
    0;JMP
