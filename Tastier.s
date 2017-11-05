; Procedure FuncA
FuncABody
    LDR     R5, =10
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; m
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from FuncA
FuncA
    LDR     R0, =1          ; current lexic level
    LDR     R1, =1          ; number of local variables
    BL      enter           ; build new stack frame
    B       FuncABody
 ; variable local int m
 ; variable global int value
 ; array global int arrayPotter
 ; process global void FuncA
; Procedure FuncB
FuncBBody
    LDR     R5, =10
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; m
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from FuncB
FuncB
    LDR     R0, =1          ; current lexic level
    LDR     R1, =1          ; number of local variables
    BL      enter           ; build new stack frame
    B       FuncBBody
 ; variable local int m
 ; variable local int m
 ; process global void FuncB
 ; variable global int value
 ; array global int arrayPotter
 ; process global void FuncA
MainBody
    LDR     R5, =1
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; i
    LDR     R5, =3
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; j
    LDR     R5, =100
    ADD     R2, BP, #16
    LDR     R1, =2
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; f
    LDR     R5, =455
    ADD     R2, BP, #16
    LDR     R1, =3
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; h
    LDR     R5, =100
    LDR     R2, =0
    STR     R5, [R4, R2, LSL #2] ; value
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L1
    DCB     "///////", 0
    ALIGN
L1
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; j
    LDR     R6, =10
    CMP     R5, R6
    MOVGE   R5, #1
    MOVLT   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L2              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    LDR     R6, =1
    ADD     R5, R5, R6
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; i
    B       L3
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    LDR     R6, =1
    SUB     R5, R5, R6
L2
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; i
L3
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L4
    DCB     "-------", 0
    ALIGN
L4
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "///////", 0
    ALIGN
L5
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    MOV     R0, R5
    BL      TastierPrintInt
L8
    LDR     R5, =1
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R6, [R2]        ; j
    CMP     R6, R5
    MOVEQ   R6, #1
    MOVNE   R6, #0
    MOVS    R6, R6          ; reset Z flag in CPSR
    BEQ     L9              ; jump on condition false
    LDR     R7, =1
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R7, [R2]        ; i
    B       L6
L9
    LDR     R5, =2
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R6, [R2]        ; j
    CMP     R6, R5
    MOVEQ   R6, #1
    MOVNE   R6, #0
    MOVS    R6, R6          ; reset Z flag in CPSR
    BEQ     L10              ; jump on condition false
    LDR     R7, =2
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R7, [R2]        ; i
    B       L6
L10
    LDR     R5, =3
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R6, [R2]        ; j
    CMP     R6, R5
    MOVEQ   R6, #1
    MOVNE   R6, #0
    MOVS    R6, R6          ; reset Z flag in CPSR
    BEQ     L11              ; jump on condition false
    LDR     R7, =3
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R7, [R2]        ; i
    B       L6
L11
L6
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L12
    DCB     "------", 0
    ALIGN
L12
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    MOV     R5, R2
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    MOV     R6, R2
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       FuncA
    ADD     R2, BP, #16
    LDR     R1, =2
    ADD     R2, R2, R1, LSL #2
    MOV     R5, R2
    ADD     R2, BP, #16
    LDR     R1, =3
    ADD     R2, R2, R1, LSL #2
    MOV     R6, R2
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       FuncB
    LDR     R7, =0
    LDR     R8, =100
    LDR     R2, =0
    ADD     R2, R4, R2, LSL #2
    STR     R8, [R2, R7, LSL #2] ; value of arrayPotter[]
    LDR     R5, =1
    LDR     R6, =50
    LDR     R2, =0
    ADD     R2, R4, R2, LSL #2
    STR     R6, [R2, R5, LSL #2] ; value of arrayPotter[]
    LDR     R5, =2
    LDR     R6, =3
    LDR     R2, =0
    ADD     R2, R4, R2, LSL #2
    STR     R6, [R2, R5, LSL #2] ; value of arrayPotter[]
    LDR     R5, =3
    LDR     R6, =1
    LDR     R2, =0
    ADD     R2, R4, R2, LSL #2
    STR     R6, [R2, R5, LSL #2] ; value of arrayPotter[]
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L13
    DCB     "/////// value after loading afrom array/////", 0
    ALIGN
L13
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L14
    DCB     "-----------", 0
    ALIGN
L14
    LDR     R2, =0
    LDR     R5, [R4, R2, LSL #2] ; value
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L15
    DCB     "/////// j before for loop /////", 0
    ALIGN
L15
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; j
    MOV     R0, R5
    BL      TastierPrintInt
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; i
L16
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    LDR     R6, =5
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L17              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; i
    LDR     R6, =1
    ADD     R5, R5, R6
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; i
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; j
    LDR     R6, =1
    ADD     R5, R5, R6
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; j
    B       L16
L17
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L18
    DCB     "--------", 0
    ALIGN
L18
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; j
    MOV     R0, R5
    BL      TastierPrintInt
StopTest
    B       StopTest
Main
    LDR     R0, =1          ; current lexic level
    LDR     R1, =8          ; number of local variables
    BL      enter           ; build new stack frame
    B       MainBody
 ; variable local int i
 ; variable local int j
 ; variable local int f
 ; variable local int h
 ; variable local int m
 ; process global void main
 ; variable local int m
 ; process global void FuncB
 ; variable global int value
 ; array global int arrayPotter
 ; process global void FuncA
 ; variable local int i
 ; variable local int j
 ; variable local int f
 ; variable local int h
 ; variable local int m
 ; process global void main
 ; variable local int m
 ; process global void FuncB
 ; variable global int value
 ; array global int arrayPotter
 ; process global void FuncA
